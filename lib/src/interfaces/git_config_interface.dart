import 'package:simple_process/simple_process.dart';

abstract class IGitConfig<T> {
  /// Git init
  T init(
      {List<String>? options,
      bool skipOnError = false,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Config user name
  T setGlobalUserName(String userName,
      {List<String>? options,
      bool skipOnError = false,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Config user name
  T getGlobalUserName(
      {List<String>? options,
      bool skipOnError = false,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Set user email
  T setGlobalUserEmail(String userEmail,
      {List<String>? options,
      bool skipOnError = false,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Get user email
  T getGlobalUserEmail(String userEmail,
      {List<String>? options,
      bool skipOnError = false,
      HandlerFunction? handlerFn,
      bool? showOutput});
}
