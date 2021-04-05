import 'package:simple_git/simple_git.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    SimpleGit? git;

    setUp(() {
      git = SimpleGit(options: SimpleGitOptions(binary: 'git'));
    });

    test('First Test', () {
      expect(git.runtimeType, SimpleGit);
    });
  });
}
