import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../annotations.dart';

class FieldsGenerator extends GeneratorForAnnotation<Fields> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final value = Fields(
      caseStyle: FieldsCodeStyle.values.firstWhere(
        (e) => e.toString() == annotation.read('caseStyle').stringValue,
      ),
      generateEnum: annotation.read('generateEnum').boolValue,
      includePrivate: annotation.read('includePrivate').boolValue,
      includeStatic: annotation.read('includeStatic').boolValue,
    );

    return 'const x = $value;';
  }
}