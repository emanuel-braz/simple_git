import 'dart:io';
import 'package:simple_git/src/interfaces/git_basic_interface.dart';
import 'package:simple_process/simple_process.dart';
import 'package:simple_git/src/simple_git_base.dart';

mixin GitBasicMixin<T> on GitBase<T> implements IGitBasic<T> {
  @override
  T status({bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput}) =>
      runner.run(
          args: ['status'],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T addAll({bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput}) =>
      runner.run(
          args: ['add', '.'],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T pull(
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['pull', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T pullRebase(
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['pull', '--rebase', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T push(
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['push', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T commit(String message,
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['commit', '-m', message, ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T rebase(
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['rebase', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T add(
      {String? file,
      List<String>? files,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput}) {
    if (skipOnError == false &&
        ((file != null && files != null) || (file == null && files == null))) {
      throw SimpleProcessResult(
          processResult: ProcessResult(0, 1, '',
              'Please enter the file or files, and not both in same time'));
    }

    var f;
    if (file != null) {
      f = [file];
    } else {
      f = files;
    }

    return runner.run(
        args: ['add', ...?f],
        showOutput: showOutput,
        handlerFn: handlerFn,
        skipOnError: skipOnError);
  }

  @override
  T raw(List<String> args,
          {bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput}) =>
      runner.run(
          args: args,
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T checkout(
          {List<String>? options,
          bool? skipOnError,
          handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['checkout', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T branch(
          {List<String>? options,
          bool? skipOnError,
          handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['branch', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T merge(
      {String? branch,
      List<String>? options = const [],
      bool? skipOnError,
      handlerFn,
      bool? showOutput}) {
    if (branch != null) {
      options!.insert(0, branch);
    }
    return runner.run(
        args: ['merge', ...options!],
        showOutput: showOutput,
        handlerFn: handlerFn,
        skipOnError: skipOnError);
  }

  @override
  T fetch(
          {List<String>? options,
          bool? skipOnError,
          handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['fetch', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T tag(
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['tag', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T addTag(String tagName,
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['tag', tagName, ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T addAnnotatedTag(String tagName, String tagMessage,
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      runner.run(
          args: ['tag', '-a', tagName, '-m', tagMessage, ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);
}
