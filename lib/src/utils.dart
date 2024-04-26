import 'package:analyzer/dart/constant/value.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

T? readEnum<T extends Enum>(
  ConstantReader reader,
  List<T> values,
) {
  return reader.isNull
      ? null
      : enumValueForDartObject<T>(reader.objectValue, values, (f) => f.name);
}

T enumValueForDartObject<T>(
  DartObject source,
  List<T> items,
  String Function(T) name,
) =>
    items[source.getField('index')!.toIntValue()!];

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
