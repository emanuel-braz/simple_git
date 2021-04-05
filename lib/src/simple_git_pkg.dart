import 'package:simple_git/src/simple_git_base.dart';
import 'package:simple_process/simple_process.dart';

class SimpleGit extends SimpleGitPkg<SimpleProcessResult> {
  SimpleGit({SimpleProcessOptions? options})
      : super(SimpleProcess(options ?? SimpleProcessOptions(binary: 'git')));
}

class SimpleGitAsync extends SimpleGitPkg<Future<SimpleProcessResult>> {
  SimpleGitAsync({SimpleProcessOptions? options})
      : super(
            SimpleProcessAsync(options ?? SimpleProcessOptions(binary: 'git')));
}
