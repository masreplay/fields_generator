/// build
library fields_generator.builder;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/member_count_library_generator.dart';
import 'src/multiplier_generator.dart';
import 'src/property_product_generator.dart';
import 'src/property_sum_generator.dart';

Builder metadataLibraryBuilder(BuilderOptions options) => LibraryBuilder(
      MemberCountLibraryGenerator(),
      generatedExtension: '.info.dart',
    );

Builder productBuilder(BuilderOptions options) =>
    SharedPartBuilder([PropertyProductGenerator()], 'product');

Builder sumBuilder(BuilderOptions options) =>
    SharedPartBuilder([PropertySumGenerator()], 'sum');

Builder multiplyBuilder(BuilderOptions options) =>
    SharedPartBuilder([MultiplierGenerator()], 'multiply');
