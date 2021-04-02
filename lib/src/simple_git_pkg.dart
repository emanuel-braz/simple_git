import 'dart:io';
import 'package:simple_git/src/models/simple_git_options.dart';
import 'package:simple_git/src/simple_git_base.dart';

typedef HandlerFunction = void Function(ProcessResult);

class SimpleGit extends SimpleGitPkg<ProcessResult> {
  SimpleGit(SimpleGitOptions simpleGitOptions) : super(simpleGitOptions);
}

class SimpleGitAsync extends SimpleGitPkg<Future<ProcessResult>> {
  SimpleGitAsync(SimpleGitOptions simpleGitOptions) : super(simpleGitOptions);
}
