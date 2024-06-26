/// build
library fields_generator.builder;

import 'package:build/build.dart';
import 'src/fields_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder fieldsLibraryBuilder(BuilderOptions options) => LibraryBuilder(
      FieldsLibraryGenerator(),
      generatedExtension: '.fields.dart',
    );
