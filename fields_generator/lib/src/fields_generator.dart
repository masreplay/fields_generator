import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:fields_generator/src/utils.dart';
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
      includePrivate: annotation.read('includePrivate').boolValue,
      includeStatic: annotation.read('includeStatic').boolValue,
      type: readEnum(annotation.read('type'), FieldClassType.values),
      fieldRename:
          readEnum(annotation.read("fieldRename"), FieldRename.values) ??
              FieldRename.none,
    );

    final type = annotationValue.type;

    final code = StringBuffer();

    final fileName =
        element.library!.source.uri.pathSegments.last.split(".").first;
    code.writeln("part of '${fileName}.dart';");

    if (type == FieldClassType.classType || type == null) {
      code.writeln(_generateClassCode(element, annotationValue));
    }

    if (type == FieldClassType.enumType || type == null) {
      code.writeln(_generateEnumCode(element, annotationValue));
    }

    return code.toString();
  }

  String _generateClassCode(Element element, Fields annotationValue) {
    final code = StringBuffer();

    if (element is ClassElement) {
      final includedFields = element.fields.where(
        (field) {
          return !field.isStatic &&
              (annotationValue.includePrivate || !field.isPrivate) &&
              (annotationValue.includeStatic || !field.isStatic);
        },
      ).toList();

      final String className = element.name;
      final String fieldsClassName = "${className}Fields";

      code.writeln('/// [$className] fields');
      code.writeln('abstract final class $fieldsClassName {');
      code.writeln('  const $fieldsClassName._();');
      code.writeln();

      final fieldsNames = <String>[];

      for (final field in includedFields) {
        final name = field.name;
        final value = encodedFieldName(
          annotationValue.fieldRename,
          name,
        );

        final String fieldName;
        if (name.startsWith("_")) {
          fieldName = "private${name.nonPrivate.pascal}FieldName";
        } else {
          fieldName = "${name}FieldName";
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

  String _generateEnumCode(Element element, Fields annotationValue) {
    final code = StringBuffer();

    if (element is ClassElement) {
      final includedFields = element.fields.where(
        (field) {
          return !field.isStatic &&
              (annotationValue.includePrivate || !field.isPrivate) &&
              (annotationValue.includeStatic || !field.isStatic);
        },
      ).toList();

      final String className = element.name;
      final String fieldsEnumName = "${className}FieldsEnum";

      code.writeln('/// [${className}] fields');
      code.writeln('@JsonEnum(');
      code.writeln('  fieldRename: ${annotationValue.fieldRename},');
      code.writeln(')');
      code.writeln('enum $fieldsEnumName {');

      for (final field in includedFields) {
        final name = field.name;
        final value = encodedFieldName(
          annotationValue.fieldRename,
          name,
        );

        code.writeln('  $value,');
      }

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

@JsonEnum(fieldRename: FieldRename.snake)
enum UserFieldsEnum { name, age }
