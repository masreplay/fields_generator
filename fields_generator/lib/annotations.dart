import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class Fields {
  final FieldRename fieldRename;
  final bool includePrivate;
  final bool includeStatic;
  final bool generateEnum;

  const Fields({
    this.fieldRename = FieldRename.none,
    this.includePrivate = false,
    this.includeStatic = false,
    this.generateEnum = false,
  });
}
