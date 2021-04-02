import 'dart:io';
import 'package:simple_git/src/models/git_exception.dart';
import 'package:simple_git/src/models/simple_git_options.dart';
import 'package:simple_git/src/simple_git_pkg.dart';

class ProcessUtil {
  final SimpleGitOptions simpleGitOptions;
  ProcessUtil(this.simpleGitOptions);

  dynamic runProcess<T>(
    String exec, {
    List<String>? args,
    bool? showOutput,
    HandlerFunction? handlerFn,
    bool? skipOnError,
  }) {
    if (T == ProcessResult) {
      return runSyncProcess(exec,
          args: args,
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);
    } else {
      return runAsyncProcess(exec,
          args: args,
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);
    }
  }

  ProcessResult runSyncProcess(
    String exec, {
    List<String>? args = const <String>[],
    bool? showOutput,
    HandlerFunction? handlerFn,
    bool? skipOnError,
  }) {
    skipOnError = skipOnError ?? false;
    showOutput = showOutput ?? simpleGitOptions.showOutput;

    var result = Process.runSync(exec, _injectConfiguration(args),
        workingDirectory: simpleGitOptions.baseDir,
        runInShell: simpleGitOptions.runInShell,
        stdoutEncoding: simpleGitOptions.stdoutEncoding,
        stderrEncoding: simpleGitOptions.stderrEncoding);

    if (showOutput == true) {
      stdout.write(result.stdout);
      stderr.write(result.stderr);
    }

    handlerFn?.call(result);

    if (skipOnError == false && result.exitCode != 0) {
      throw GitException(result);
    } else {
      return result;
    }
  }

  Future<ProcessResult> runAsyncProcess(
    String exec, {
    List<String>? args = const <String>[],
    bool? showOutput,
    HandlerFunction? handlerFn,
    bool? skipOnError,
  }) async {
    skipOnError = skipOnError ?? false;
    showOutput = showOutput ?? simpleGitOptions.showOutput;

    return Process.run(exec, _injectConfiguration(args),
            workingDirectory: simpleGitOptions.baseDir,
            runInShell: simpleGitOptions.runInShell,
            stdoutEncoding: simpleGitOptions.stdoutEncoding,
            stderrEncoding: simpleGitOptions.stderrEncoding)
        .then((result) {
      if (showOutput == true) {
        stdout.write(result.stdout);
        stderr.write(result.stderr);
      }

      handlerFn?.call(result);

      if (skipOnError == false && result.exitCode != 0) {
        throw GitException(result);
      } else {
        return result;
      }
    });
  }

  List<String> _injectConfiguration(List<String>? args) {
    if (simpleGitOptions.config != null &&
        (simpleGitOptions.config?.isNotEmpty ?? false)) {
      args?.insert(0, simpleGitOptions.config!);
      args?.insert(0, '-c');
    }
    return args ?? [];
  }
}
