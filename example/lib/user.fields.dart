// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// FieldsLibraryGenerator
// **************************************************************************

part of 'user.dart';

/// [User] fields
abstract final class UserFields {
  const UserFields._();

  /// [User.firstName]
  static const String firstNameFieldName = 'first_name';

  /// [User.example]
  static const String exampleFieldName = 'example';

  /// [User._]
  static const String privateFieldName = '_';

  /// [User._test]
  static const String privateTestFieldName = '_test';

  /// [User.tester]
  static const String testerFieldName = 'tester';

  static const List<String> fieldsNames = [
    firstNameFieldName,
    exampleFieldName,
    privateFieldName,
    privateTestFieldName,
    testerFieldName
  ];
}

/// [User] fields
@JsonEnum(
  fieldRename: FieldRename.snake,
)
enum UserFieldsEnum {
  first_name,
  example,
  _,
  _test,
  tester,
}
