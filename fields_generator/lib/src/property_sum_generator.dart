import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'utils.dart';

class PropertySumGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final sumNames = topLevelNumVariables(library)
        .map((element) => element.name)
        .join(' + ');

    return '''
num allSum() => $sumNames;
''';
  }
}
