import 'package:json_annotation/json_annotation.dart';

class Fields {
  final bool includePrivate;
  final bool includeStatic;
  final bool generateEnum;
  final FieldRename caseStyle;

  const Fields({
    this.includePrivate = false,
    this.includeStatic = false,
    this.generateEnum = false,
    this.caseStyle = FieldRename.none,
  });
}
