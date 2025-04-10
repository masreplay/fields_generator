import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'annotations.dart';

class FieldsLibraryGenerator extends GeneratorForAnnotation<Fields> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final annotationValue = Fields(
      includePrivate: annotation.read(FieldsNames.includePrivate).boolValue,
      includeStatic: annotation.read(FieldsNames.includeStatic).boolValue,
      type: readEnum(annotation.read(FieldsNames.type), FieldClassType.values),
      excludeFields:
          annotation
              .read(FieldsNames.excludeFields)
              .listValue
              .map((e) => e.toStringValue()!)
              .toList(),
      fieldRename:
          readEnum(
            annotation.read(FieldsNames.fieldRename),
            FieldRename.values,
          ) ??
          FieldRename.none,
      suffix: annotation.read(FieldsNames.suffix).stringValue,
    );

    final type = annotationValue.type;

    final code = StringBuffer();

    final fileName =
        element.library!.source.uri.pathSegments.last.split('.').first;
    code.writeln("part of '${fileName}.dart';");

    if (type == FieldClassType.classType || type == null) {
      code.writeln(_generateClassCode(element, annotationValue));
    }

    if (type == FieldClassType.enumType || type == null) {
      code.writeln(_generateEnumCode(element, annotationValue));
    }

    return code.toString();
  }

  List<FieldElement> _includedFields(ClassElement element, Fields annotation) {
    return element.fields.where((field) {
      return !field.isStatic &&
          (annotation.includePrivate || !field.isPrivate) &&
          (annotation.includeStatic || !field.isStatic) &&
          !annotation.excludeFields.contains(field.name);
    }).toList();
  }

  String _generateClassCode(Element element, Fields annotation) {
    final code = StringBuffer();

    if (element is ClassElement) {
      final includedFields = _includedFields(element, annotation);

      final String className = _className(element.name);
      final String fieldsClassName = '${className}Fields';

      code.writeln('/// [$className] fields');
      code.writeln('abstract final class $fieldsClassName {');
      code.writeln('  const $fieldsClassName._();');
      code.writeln();

      final fieldsNames = <String>[];

      for (final field in includedFields) {
        final name = field.name;
        final value = encodedFieldName(annotation.fieldRename, name);

        final String fieldName;
        if (name.startsWith('_')) {
          fieldName = 'private${name.nonPrivate.pascal}${annotation.suffix}';
        } else {
          fieldName = '${name}${annotation.suffix}';
        }

        fieldsNames.add(fieldName);

        code.writeln('  /// [${className}.$name]');
        code.writeln('  static const String $fieldName = \'$value\';');
      }

      code.writeln();

      code.writeln(
        '  static const List<String> fieldsNames = [${fieldsNames.join(', ')}];',
      );

      code.writeln('}');
    }

    return code.toString();
  }

  String _className(String name) {
    return name
        .replaceFirst('_\$', '')
        .replaceFirst('_', '')
        .replaceFirst('Impl', '');
  }

  String _generateEnumCode(Element element, Fields annotation) {
    final code = StringBuffer();

    if (element is ClassElement) {
      final includedFields = _includedFields(element, annotation);

      final className = _className(element.name);

      final String enumName = '${className}FieldsEnum';

      code.writeln('/// [${className}] fields');
      code.writeln('@JsonEnum(');
      code.writeln('  fieldRename: ${annotation.fieldRename},');
      code.writeln('  valueField: \'value\',');
      code.writeln(')');
      code.writeln('enum $enumName {');

      for (final (index, field) in includedFields.indexed) {
        final name = field.name;
        final value = encodedFieldName(annotation.fieldRename, name);

        if (index == includedFields.length - 1) {
          code.writeln('  $name(\'$value\');');
        } else {
          code.writeln('  $name(\'$value\'),');
        }
      }
      code.writeln('  final String value;');
      code.writeln('  const $enumName(this.value);');

      code.writeln('}');
    }

    return code.toString();
  }
}

/// code
@Fields()
class User {
  final String name;
  final int age;

  User({required this.name, required this.age});
}

/// generated code
abstract final class UserFields {
  UserFields._();

  static const String name = 'name';

  static const String age = 'age';

  static const List<String> fieldsNames = [name, age];
}

@JsonEnum(alwaysCreate: true, valueField: 'value')
enum UserFieldsEnum {
  name('name'),
  age('age');

  final String value;
  const UserFieldsEnum(this.value);
}
