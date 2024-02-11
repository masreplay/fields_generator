// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// FieldsLibraryGenerator
// **************************************************************************

part of 'user.dart';

/// [User] fields
abstract final class UserFields {
  const UserFields._();

  /// [User.name]
  static const String nameFieldName = 'name';

  /// [User.age]
  static const String ageFieldName = 'age';

  static const List<String> fieldsNames = [nameFieldName, ageFieldName];
}

/// [User] fields
@JsonEnum(
  fieldRename: FieldRename.none,
  valueField: 'value',
)
enum UserFieldsEnum {
  name('name'),
  age('age');

  final String value;
  const UserFieldsEnum(this.value);
}
