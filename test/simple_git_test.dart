import 'package:simple_git/simple_git.dart';
import 'package:simple_process/simple_process.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    SimpleGit? git;

    setUp(() {
      git = SimpleGit(SimpleProcessOptions(binary: 'git'));
    });

    test('First Test', () {
      expect(git.runtimeType, SimpleGit);
    });
  });
}
