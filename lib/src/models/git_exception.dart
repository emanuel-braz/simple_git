import 'dart:io';

class GitException extends ProcessResult {
  final ProcessResult processResult;
  GitException(this.processResult)
      : super(processResult.pid, processResult.exitCode, processResult.stdout,
            processResult.stderr);

  bool get isOk => exitCode == 1;
  bool get hasOutput =>
      stdout.runtimeType == String && (stdout as String).isNotEmpty;
  bool get hasError =>
      stderr.runtimeType == String && (stderr as String).isNotEmpty;

  @override
  String toString() => processResult.stderr.toString();
}
