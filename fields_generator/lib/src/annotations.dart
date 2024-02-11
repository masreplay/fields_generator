import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class Fields {
  final FieldRename fieldRename;

  final FieldClassType? type;

  final bool includePrivate;

  final bool includeStatic;

  const Fields({
    this.fieldRename = FieldRename.none,
    this.includePrivate = false,
    this.includeStatic = false,
    this.type,
  });
}

enum FieldClassType { classType, enumType }
