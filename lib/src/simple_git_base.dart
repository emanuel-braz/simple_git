import 'package:simple_git/src/mixins/git_basic_mixin.dart';
import 'package:simple_process/simple_process.dart';

class SimpleGitPkg<T> extends GitBase<T> with GitBasicMixin<T> {
  SimpleGitPkg(SimpleProcessBase process) : super(process);
}

class GitBase<T> {
  final SimpleProcessBase runner;
  GitBase(this.runner);
}
