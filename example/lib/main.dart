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
