import 'package:json_annotation/json_annotation.dart';

const Fields fields = Fields();

class FieldsNames {
  static const String fieldRename = 'fieldRename';

  static const String type = 'type';

  static const String includePrivate = 'includePrivate';

  static const String includeStatic = 'includeStatic';

  static const String excludeFields = 'excludeFields';

  static const String suffix = 'suffix';
}

class Fields {
  final FieldRename fieldRename;

  final FieldClassType? type;

  final bool includePrivate;

  final bool includeStatic;

  final List<String> excludeFields;

  final String suffix;

  const Fields({
    this.fieldRename = FieldRename.none,
    this.includePrivate = false,
    this.includeStatic = false,
    this.excludeFields = const ['copyWith', 'toJson', 'fromJson', 'hashCode'],
    this.suffix = '',
    this.type,
  });
}

enum FieldClassType { classType, enumType }
