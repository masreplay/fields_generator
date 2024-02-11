import 'package:fields_generator/fields_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.fields.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  // ignore: invalid_annotation_target
  @Fields()
  factory User({
    required String name,
    required int age,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
