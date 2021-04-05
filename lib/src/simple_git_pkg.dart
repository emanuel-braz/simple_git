import 'package:simple_git/src/simple_git_base.dart';
import 'package:simple_process/simple_process.dart';

class SimpleGit extends SimpleGitPkg<SimpleProcessResult> {
  SimpleGit(SimpleProcessOptions simpleGitOptions)
      : super(SimpleProcess(simpleGitOptions));
}

class SimpleGitAsync extends SimpleGitPkg<Future<SimpleProcessResult>> {
  SimpleGitAsync(SimpleProcessOptions simpleGitOptions)
      : super(SimpleProcessAsync(simpleGitOptions));
}
