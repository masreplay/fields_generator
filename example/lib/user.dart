import 'package:fields_generator/annotations.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@Fields(includePrivate: true)
class User {
  const User({
    required this.example,
    required String value,
    required String test,
  })  : _ = 0,
        _test = 0;

  final int example;
  final int _;
  final int _test;

  String get tester => '';

  void greeting() {}
}
