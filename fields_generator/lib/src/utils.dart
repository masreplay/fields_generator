import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// Returns all [TopLevelVariableElement] members in [reader]'s library that
/// have a type of [num].
Iterable<TopLevelVariableElement> topLevelNumVariables(LibraryReader reader) =>
    reader.allElements.whereType<TopLevelVariableElement>().where(
          (element) =>
              element.type.isDartCoreNum ||
              element.type.isDartCoreInt ||
              element.type.isDartCoreDouble,
        );
