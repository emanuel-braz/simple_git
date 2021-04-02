import 'package:simple_git/simple_git.dart';
import 'package:simple_git/src/models/simple_git_options.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    SimpleGit? awesome;

    setUp(() {
      awesome = SimpleGit(SimpleGitOptions());
    });

    test('First Test', () {
      expect(awesome.runtimeType, SimpleGit);
    });
  });
}
