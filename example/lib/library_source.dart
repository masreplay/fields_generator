import 'package:fields_generator/annotations.dart';

part 'library_source.g.dart';

@Fields(
  caseStyle: FieldsCodeStyle.snake,
  generateEnum: true,
  includePrivate: true,
  includeStatic: true,
)
class Example {
  final int exampleField;

  Example({required this.exampleField});
}
