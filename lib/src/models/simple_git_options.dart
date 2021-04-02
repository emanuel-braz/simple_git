import 'dart:convert';
import 'dart:io';

class SimpleGitOptions<T> {
  /// working directory for `git` commands to run in
  late String baseDir;

  /// git bynary on the machine
  final String binary;

  /// Not used yet
  final int maxConcurrentProcesses;

  final bool runInShell;
  final Encoding stdoutEncoding;
  final Encoding stderrEncoding;

  /// Show all outputs (Debug mode) - default = false
  final showOutput;

  /// Any command executed will be prefixed with this config
  /// E.g. `SimpleGit().pull();`
  ///   runs: git -c <config> pull
  final String? config;

  SimpleGitOptions(
      {baseDir,
      this.binary = 'git',
      this.maxConcurrentProcesses = 6,
      this.config,
      this.runInShell = false,
      this.stdoutEncoding = systemEncoding,
      this.stderrEncoding = systemEncoding,
      this.showOutput = false})
      : baseDir = baseDir ?? Directory.current.path;
}
