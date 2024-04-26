# Fields Generator

This package provides a Dart and Flutter field name code generation for class.


# Used for
- Firebase query field name
- Supabase query field name 


## Usage

```dart
import 'package:fields_generator/fields_generator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main.fields.dart';

@fields()
class User {
  User({
    required this.name,
    required this.age,
  });

  final String name;
  final int age;
}


void main(List<String> args) {
  print(UserFields.nameFieldName); // output: name
  print(UserFields.ageFieldName); // output: age
}
```

## Generated code

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// FieldsLibraryGenerator
// **************************************************************************

part of 'main.dart';

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
)
enum UserFieldsEnum {
  name,
  age,
}
```

## Working with freezed
```dart
import 'package:fields_generator/fields_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.fields.dart';
part 'main.freezed.dart';
part 'main.g.dart';

@freezed
class User with _$User {
  @fields
  @JsonSerializable()
  factory User({
    required String name,
    required int age,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

## Features
- [x] Generate fields name for class

## Getting started
In your `pubspec.yaml` file, add the following dependency:

```yaml
dependencies:
  fields_generator: 
```

Then, run `flutter pub get` in your terminal.

or run this command:
    
```shell
flutter pub add fields_generator
```

## Additional information

This package is still in development, and the API is subject to change.
feel free to contribute to this package.

## License
Read more about the license [here](./LICENSE)