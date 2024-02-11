import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'utils.dart';

class MemberCountLibraryGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final topLevelVarCount = topLevelNumVariables(library).length;

    return '''
// Source library: ${library.element.source.uri}
const topLevelNumVarCount = $topLevelVarCount;
''';
  }
}
