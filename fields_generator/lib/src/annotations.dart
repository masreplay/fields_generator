import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta_meta.dart';

const Fields fields = Fields();

@Target({TargetKind.classType})
class Fields {
  final FieldRename fieldRename;

  final FieldClassType? type;

  final bool includePrivate;

  final bool includeStatic;

  final List<String> excludeFields;

  const Fields({
    this.fieldRename = FieldRename.none,
    this.includePrivate = false,
    this.includeStatic = false,
    this.excludeFields = const ["copyWith", "toJson", "fromJson"],
    this.type,
  });
}

enum FieldClassType { classType, enumType }
