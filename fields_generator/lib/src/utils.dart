// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

const _jsonKeyChecker = TypeChecker.fromRuntime(JsonKey);

DartObject? _jsonKeyAnnotation(FieldElement element) =>
    _jsonKeyChecker.firstAnnotationOf(element) ??
    (element.getter == null
        ? null
        : _jsonKeyChecker.firstAnnotationOf(element.getter!));

ConstantReader jsonKeyAnnotation(FieldElement element) =>
    ConstantReader(_jsonKeyAnnotation(element));

/// Returns `true` if [element] is annotated with [JsonKey].
bool hasJsonKeyAnnotation(FieldElement element) =>
    _jsonKeyAnnotation(element) != null;

Never throwUnsupported(FieldElement element, String message) =>
    throw InvalidGenerationSourceError(
      'Error with `@JsonKey` on the `${element.name}` field. $message',
      element: element,
    );

T? readEnum<T extends Enum>(ConstantReader reader, List<T> values) =>
    reader.isNull
        ? null
        : enumValueForDartObject<T>(
            reader.objectValue,
            values,
            (f) => f.name,
          );

T enumValueForDartObject<T>(
  DartObject source,
  List<T> items,
  String Function(T) name,
) =>
    items[source.getField('index')!.toIntValue()!];

/// Return an instance of [JsonSerializable] corresponding to the provided
/// [reader].
// #CHANGE WHEN UPDATING json_annotation
JsonSerializable _valueForAnnotation(ConstantReader reader) => JsonSerializable(
      anyMap: reader.read('anyMap').literalValue as bool?,
      checked: reader.read('checked').literalValue as bool?,
      constructor: reader.read('constructor').literalValue as String?,
      createFactory: reader.read('createFactory').literalValue as bool?,
      createToJson: reader.read('createToJson').literalValue as bool?,
      createFieldMap: reader.read('createFieldMap').literalValue as bool?,
      createPerFieldToJson:
          reader.read('createPerFieldToJson').literalValue as bool?,
      disallowUnrecognizedKeys:
          reader.read('disallowUnrecognizedKeys').literalValue as bool?,
      explicitToJson: reader.read('explicitToJson').literalValue as bool?,
      fieldRename: readEnum(reader.read('fieldRename'), FieldRename.values),
      genericArgumentFactories:
          reader.read('genericArgumentFactories').literalValue as bool?,
      ignoreUnannotated: reader.read('ignoreUnannotated').literalValue as bool?,
      includeIfNull: reader.read('includeIfNull').literalValue as bool?,
    );

ConstructorElement constructorByName(ClassElement classElement, String name) {
  final className = classElement.name;

  ConstructorElement? ctor;
  if (name.isEmpty) {
    ctor = classElement.unnamedConstructor;
    if (ctor == null) {
      throw InvalidGenerationSourceError(
        'The class `$className` has no default constructor.',
        element: classElement,
      );
    }
  } else {
    ctor = classElement.getNamedConstructor(name);
    if (ctor == null) {
      throw InvalidGenerationSourceError(
        'The class `$className` does not have a constructor with the name '
        '`$name`.',
        element: classElement,
      );
    }
  }

  return ctor;
}

/// If [targetType] is an enum, returns the [FieldElement] instances associated
/// with its values.
///
/// Otherwise, `null`.
Iterable<FieldElement>? iterateEnumFields(DartType targetType) {
  if (targetType is InterfaceType && targetType.element is EnumElement) {
    return targetType.element.fields.where((element) => element.isEnumConstant);
  }
  return null;
}

extension DartTypeExtension on DartType {
  DartType promoteNonNullable() =>
      element?.library?.typeSystem.promoteToNonNull(this) ?? this;
}

String ifNullOrElse(String test, String ifNull, String ifNotNull) =>
    '$test == null ? $ifNull : $ifNotNull';

String encodedFieldName(
  FieldRename fieldRename,
  String declaredName,
) =>
    switch (fieldRename) {
      FieldRename.none => declaredName,
      FieldRename.snake => declaredName.snake,
      FieldRename.screamingSnake => declaredName.snake.toUpperCase(),
      FieldRename.kebab => declaredName.kebab,
      FieldRename.pascal => declaredName.pascal
    };

/// Return the Dart code presentation for the given [type].
///
/// This function is intentionally limited, and does not support all possible
/// types and locations of these files in code. Specifically, it supports
/// only [InterfaceType]s, with optional type arguments that are also should
/// be [InterfaceType]s.
String typeToCode(
  DartType type, {
  bool forceNullable = false,
}) {
  if (type is DynamicType) {
    return 'dynamic';
  } else if (type is InterfaceType) {
    return [
      type.element.name,
      if (type.typeArguments.isNotEmpty)
        '<${type.typeArguments.map(typeToCode).join(', ')}>',
      (type.isNullableType || forceNullable) ? '?' : '',
    ].join();
  }

  if (type is TypeParameterType) {
    return type.getDisplayString(withNullability: false);
  }
  throw UnimplementedError('(${type.runtimeType}) $type');
}

extension ExecutableElementExtension on ExecutableElement {
  /// Returns the name of `this` qualified with the class name if it's a
  /// [MethodElement].
  String get qualifiedName {
    if (this is FunctionElement) {
      return name;
    }

    if (this is MethodElement) {
      return '${enclosingElement.name}.$name';
    }

    if (this is ConstructorElement) {
      // Ignore the default constructor.
      if (name.isEmpty) {
        return '${enclosingElement.name}';
      }
      return '${enclosingElement.name}.$name';
    }

    throw UnsupportedError(
      'Not sure how to support typeof $runtimeType',
    );
  }
}
