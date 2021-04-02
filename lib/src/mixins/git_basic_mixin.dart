import 'dart:io';

import 'package:simple_git/simple_git.dart';
import 'package:simple_git/src/interfaces/git_basic_interface.dart';
import 'package:simple_git/src/simple_git_base.dart';
import 'package:simple_git/src/simple_git_pkg.dart';

mixin GitBasicMixin<T> on SimpleGitBase<T> implements IGitBasic<T> {
  @override
  T status({bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput}) =>
      getProcess(
          args: ['status'],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T addAll({bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput}) =>
      getProcess(
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
      getProcess(
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
      getProcess(
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
      getProcess(
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
      getProcess(
          args: ['commit', message, ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  @override
  T rebase(
          {List<String>? options,
          bool? skipOnError,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      getProcess(
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
        ((file != null && files != null) || (file == null && files == null)))
      throw GitException(ProcessResult(0, 1, '',
          'Please enter the file or files, and not both in same time'));

    var f;
    if (file != null) {
      f = [file];
    } else {
      f = files;
    }

    return getProcess(
        args: ['add', ...?f],
        showOutput: showOutput,
        handlerFn: handlerFn,
        skipOnError: skipOnError);
  }

  @override
  T raw(List<String> args,
          {bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput}) =>
      getProcess(
          args: args,
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);
}
