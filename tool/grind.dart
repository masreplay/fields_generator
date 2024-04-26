import 'package:grinder/grinder.dart';

main(args) => grind(args);

@Task()
test() => new TestRunner().testAsync();

@DefaultTask()
@Depends(test)
build() {
  Pub.build();
}

@Task()
clean() => defaultClean();

@Task()
fix() {
  return run('dart', arguments: ['fix', '--apply']);
}

@Task()
format() {
  return run('dart', arguments: ['format', '-o', 'write', './lib']);
}

@Task()
@Depends(fix, format)
publish() {
  return run('dart', arguments: ['pub', 'publish', '--force']);
}
