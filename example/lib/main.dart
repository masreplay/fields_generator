import 'package:fields_generator/fields_generator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main.fields.dart';

@Fields()
class User {
  User({
    required this.name,
    required this.age,
  });

  final String name;
  final int age;
}
