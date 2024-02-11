import 'package:fields_generator/annotations.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.fields.dart';

@Fields(
  fieldRename: FieldRename.snake,
  includePrivate: true,
  includeStatic: true,
)
class User {
  const User(
    this.firstName, {
    required this.example,
    required String value,
    required String test,
  })  : _ = 0,
        _test = 0;

  static const String firstNameFieldName = 'first_name';

  final int firstName;
  final int example;
  final int _;
  final int _test;

  String get tester => '';
}
