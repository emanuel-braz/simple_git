import 'dart:io';
import 'package:simple_git/simple_git.dart';
import 'package:simple_git/src/extensions/process_result.ext.dart';
import 'package:simple_git/src/utils/logger/logger.dart';

var logger = LoggerUtil.verbose();

// To test this example you need to be in a git project directory
void main() async {
  // All fields are optionals
  var options = SimpleGitOptions(
    baseDir: Directory.current.path,
    showOutput:
        true, // this make all output be printed on terminal (default = false)
    binary: 'git',
    config: 'http.proxy=someproxy',
    maxConcurrentProcesses: 6,
    runInShell: true,
  );
  // runSync();
  runAsync();
}

void runSync() {
  var gitSync = SimpleGit(SimpleGitOptions());

  var result = gitSync.status();
  logger.stdout('[STATUS]: ${result.lines.first}\n\n');

  /// Only the second command will throw error exiting the app
  /// The second command occurs always after the first command finish (Sync)
  /// Param `skipOnError = true` allow it to continue to the next commands(even with previous error), but you can handle the error as you want with `handlerFn`
  /// if `skipOnError = false` (default) the second command will not be executed if a error occurs previously
  // gitSync..add(file: '*FirstErrorSkiped*', skipOnError: true)..add(file: '*SecondErrorFired*');

  try {
    ProcessResult result = gitSync.add(file: '##', skipOnError: true);
    if (result.exitCode != 0) {
      logger.stderr(
          'First error supressed, with "skipOnError: true" - pid: ${result.stderr}');
    }
    // The first command will throw error and wil be catched by Try/Catch
    // the second command will not be executed
    gitSync..add(file: '##')..add(file: '%%');
  } on GitException catch (gitException) {
    logger.stderr(
        'Second error (Try/Catch) with exit code: ${gitException.exitCode} - [Description] ${gitException.toString()}');
  } catch (e) {
    logger.stderr('Platform error $e');
  }
}

void runAsync() async {
  var gitAsync = SimpleGitAsync(SimpleGitOptions());

  try {
    ProcessResult result = await gitAsync.addAll(handlerFn: (result) {
      // ProcessResult result
      // always fired! with error or not
    });
    logger.stdout('command execute successfully, pid: ${result.pid}');
  } catch (e) {
    logger.stderr(
        'awaited error with exit code: ${(e as GitException).exitCode}');
  }

  // throw error and catch the error
  await gitAsync.add(file: '###').catchError((dynamicError) {
    GitException error = dynamicError;
    logger.stderr(
        'Current Exit code: ${error.exitCode} - [Description] ${error.stderr}');
    return error; // Need to return error, because null safety constrains
  });
  logger.stdout('awaited...');

  // Everything working together, not recommended in concurrently file access
  gitAsync
    ..addAll(handlerFn: (result) {
      logger.stdout(
          'this can be finished or not, it depends if some error get fired before');
    })
    ..add(
      file: '##',
      // skipOnError: true
    ).then((value) {
      logger.stdout('This code will never be executed');
      return value;
    }) // this will throw an error. If no catchError, it will stop all executions and exit the app
    ..addAll(handlerFn: (result) {
      logger.stdout(
          'this can be finished or not, it depends if some error get fired before');
    });
}
