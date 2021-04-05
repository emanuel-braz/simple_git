import 'package:simple_git/simple_git.dart';
import 'package:simple_git/src/utils/logger/logger.dart';
import 'package:simple_process/simple_process.dart';

var logger = LoggerUtil.verbose();

// All fields are optionals
var options = SimpleProcessOptions(
  //showOutput: false, // this make all output be printed on terminal (default = false)
  binary: 'git',
);

// To test this example you need to be in a git project directory
void main() async {
  // runSync();
  runAsync();
}

void runSync() {
  var gitSync = SimpleGit(options: options);

  var result = gitSync.status();
  logger.stdout('[STATUS]: ${result.lines.first}\n');

  /// Only the second command will throw error exiting the app
  /// The second command occurs always after the first command finish (Sync)
  /// Param `skipOnError = true` allow it to continue to the next commands(even with previous error), but you can handle the error as you want with `handlerFn`
  /// if `skipOnError = false` (default) the second command will not be executed if a error occurs previously
  // gitSync..add(file: '*FirstErrorSkiped*', skipOnError: true)..add(file: '*SecondErrorFired*');

  try {
    var result = gitSync.add(file: '##1', skipOnError: true, showOutput: true);
    if (result.exitCode != 0) {
      logger.stderr(
          'First error supressed, with "skipOnError: true" - message: ${result.resultMessage}');
    }

    // The first command will not throw error and will not be catched by Try/Catch
    // the second command will not be executed
    gitSync
      ..add(file: '##2', skipOnError: true, showOutput: true)
      ..add(file: '%%3', showOutput: true);
  } on SimpleProcessResult catch (gitException) {
    logger.stderr(
        'Third error (Try/Catch) with exit code: ${gitException.exitCode} - [Description] ${gitException.toString()}');
  } catch (e) {
    logger.stderr('Platform error $e');
  }
}

void runAsync() async {
  var gitAsync = SimpleGitAsync(options: options);

  try {
    var result = await gitAsync.addAll(handlerFn: (result) {
      // always fired! with error or not
    });
    logger.stdout(
        'command execute successfully, pid: ${result.processResult?.pid}');
  } on SimpleProcessResult catch (e) {
    logger.stderr('awaited error with exit code: ${e.exitCode}');
  } catch (e) {
    logger.stderr('Generic error: $e');
  }

  // throw error and catch the error
  await gitAsync.add(file: '###').catchError((dynamicError) {
    SimpleProcessResult error = dynamicError;
    logger.stderr(
        'Current Exit code: ${error.exitCode} - [Description] ${error.resultMessage}');
    return error; // Need to return error, because null safety constrains
  });

  logger.stdout('awaited...');

  // Everything working together, not recommended in concurrently file access
  gitAsync
    // ignore: unawaited_futures
    ..addAll(handlerFn: (result) {
      logger.stdout(
          'this can be finished or not, it depends if some error get fired before');
    })
    // ignore: unawaited_futures
    ..add(
      file: '##',
      // skipOnError: true
    ).then((value) {
      logger.stdout('This code will never be executed');
      return value;
    }) // this will throw an error. If no catchError, it will stop all executions and exit the app
    // ignore: unawaited_futures
    ..addAll(handlerFn: (result) {
      logger.stdout(
          'this can be finished or not, it depends if some error get fired before');
    });
}
