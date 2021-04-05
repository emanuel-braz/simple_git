import 'dart:io';
import 'package:simple_process/simple_process.dart';

class SimpleGitOptions extends SimpleProcessOptions {
  /// Options
  SimpleGitOptions(
      {baseDir,
      binary,
      maxConcurrentProcesses = 6,
      config,
      runInShell = false,
      stdoutEncoding = systemEncoding,
      stderrEncoding = systemEncoding,
      showOutput = false})
      : super(
            baseDir: baseDir,
            binary: binary,
            maxConcurrentProcesses: maxConcurrentProcesses,
            config: config,
            runInShell: runInShell,
            stdoutEncoding: stdoutEncoding,
            stderrEncoding: stderrEncoding,
            showOutput: showOutput);

  @override
  String toString() => ''' 
  baseDir : $baseDir
  binary : $binary
  maxConcurrentProcesses : $maxConcurrentProcesses
  config : $config
  runInShell : $runInShell
  showOutput : $showOutput
  ''';
}
