import 'package:simple_git/simple_git.dart';
import 'package:simple_git/src/interfaces/git_config_interface.dart';
import 'package:simple_git/src/simple_git_base.dart';

mixin GitConfigMixin<T> on SimpleGitBase<T> implements IGitConfig<T> {
  /// Git init
  @override
  T init(
          {List<String>? options,
          bool skipOnError = false,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      getProcess(
          args: ['init', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  /// Config user name
  @override
  T setGlobalUserName(String userName,
          {List<String>? options,
          bool skipOnError = false,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      getProcess(
          args: ['config', '--global', 'user.name', userName, ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  /// Config user name
  @override
  T getGlobalUserName(
          {List<String>? options,
          bool skipOnError = false,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      getProcess(
          args: ['config', '--global', 'user.name', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  /// Set user email
  @override
  T setGlobalUserEmail(String userEmail,
          {List<String>? options,
          bool skipOnError = false,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      getProcess(
          args: ['config', '--global', 'user.email', userEmail, ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);

  /// Get user email
  @override
  T getGlobalUserEmail(String userEmail,
          {List<String>? options,
          bool skipOnError = false,
          HandlerFunction? handlerFn,
          bool? showOutput}) =>
      getProcess(
          args: ['config', '--global', 'user.email', ...?options],
          showOutput: showOutput,
          handlerFn: handlerFn,
          skipOnError: skipOnError);
}
