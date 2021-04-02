import 'package:simple_git/src/mixins/git_basic_mixin.dart';
import 'package:simple_git/src/mixins/git_config_mixin.dart';
import 'package:simple_git/src/models/simple_git_options.dart';
import 'package:simple_git/src/simple_git_pkg.dart';
import 'package:simple_git/src/utils/process/process_util.dart';

class SimpleGitPkg<T> extends SimpleGitBase<T>
    with GitBasicMixin<T>, GitConfigMixin<T> {
  SimpleGitPkg(SimpleGitOptions simpleGitOptions) : super(simpleGitOptions);
}

class SimpleGitBase<T> {
  final SimpleGitOptions simpleGitOptions;
  ProcessUtil processUtil;
  SimpleGitBase(this.simpleGitOptions)
      : processUtil = ProcessUtil(simpleGitOptions);

  T getProcess(
          {List<String>? args,
          bool? showOutput,
          HandlerFunction? handlerFn,
          bool? skipOnError}) =>
      processUtil.runProcess<T>(simpleGitOptions.binary,
          args: args,
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);
}
