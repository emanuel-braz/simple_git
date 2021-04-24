import 'package:simple_process/simple_process.dart';

abstract class IGitBasic<T> {
  /// Pull
  T pull(
      {List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Pull
  T pullRebase(
      {List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Push
  T push(
      {List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Commits changes in the current working directory with the supplied message where the message
  /// can be either a single string or array of strings to be passed as separate arguments
  ///  (the git command line interface converts these to be separated by double line breaks)
  T commit(String message,
      {List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Rebases the repo, options should be supplied as an array of string parameters supported by the git rebase command
  T rebase(
      {List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Adds one or more files to be under source control
  T add(
      {String? file,
      List<String>? files,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Execute any arbitrary array of commands supported by the underlying git binary. When the git process returns a non-zero signal on exit and it printed something to stderr, the commmand will be treated as an error, otherwise treated as a success.
  T raw(List<String> args,
      {bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput});

  /// Show status
  T status({bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput});

  /// Add all files
  T addAll({bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput});

  /// checkout
  T checkout(
      {List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// branch
  T branch(
      {List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// branch
  T merge(
      {String branch,
      List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

  /// Update the local working copy database with changes from the default remote repo and branch, when
  /// supplied the options argument can be a standard options object either an array of string commands as supported by the git fetch.
  T fetch(
      {List<String>? options,
      bool? skipOnError,
      HandlerFunction? handlerFn,
      bool? showOutput});

/*
/// Resets the repository, commit, file...
/// Sets the reset mode to one of the supported types (ResetMode enum `GitResetEnum`, or a string equivalent: mixed, soft, hard, merge, keep)
T reset({List<String> resetOptions});

/// Adds an annotated tag to the head of the current branch
T addAnnotatedTag(String tagName, String tagMessage, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Adds a lightweight tag to the head of the current branch
T addTag(String tagName, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Generate cat-file detail, options should be an array of strings as supported arguments to the cat-file command
T catFile(List<String> options,  {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Checks if filepath excluded by .gitignore rules
T checkIgnore(List<String> filepathList, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Immediately clears the queue of pending tasks (note: any command currently in progress will still call its completion callback)
T clearQueue();

/// Commits changes on the named files with the supplied message, when supplied, the optional
/// options object can contain any other parameters to pass to the commit command, setting the
/// value of the property to be a string will add name=value to the command string, setting any
/// other type of value will result in just the key from the object being passed (ie: just name),
/// an example of setting the author is below
T commitFiles(String message, List<String>files, {List<String> options, bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Sets the command to use to reference git, allows for using a git binary not available on
/// the path environment variable
T customBinary(gitPath, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Sets the current working directory for all commands after this step in the chain
T cwd(String workingDirectory, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// get the diff of the current repo compared to the last commit with a set of options supplied as a string
/// or
/// Get the diff for all file in the current repo compared to the last commit if options not provided
T diff({List<String> options, bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Gets a summary of the diff for files in the repo, uses the git diff --stat format to calculate changes. Handler is called with a nullable error object and an instance of the DiffSummary
/// or
/// Includes options in the call to diff --stat options and returns a DiffSummary
T diffSummary({List <String> options, bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Set environment variables to be passed to the spawned child processes, see usage in detail below.
T env(String name, String value);

/// Calls a simple function in the current step
T exec(List<String> arguments, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Update the local working copy database with changes from a remote repo
T fetchFromRemote(String remote, String branch, {List<String> options, bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// List commits between options.from and options.to tags or branch (if not specified will show all history). Additionally you can provide options.file, which is the path to a file in your repository. Then only this file will be considered. options.symmetric allows you to specify whether you want to use symmetric revision range (To be compatible, by default, its value is true). For any other set of options, supply options as an array of strings to be appended to the git log command. To use a custom splitter in the log format, set options.splitter to be the string the log should be split on. Set options.multiLine to true to include a multi-line body in the output format. Options can also be supplied as a standard options object for adding custom properties supported by the git log command.
T log({List<String> options, bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Attaches a handler that will be called with the name of the command being run and the stdout and stderr readable streams created by the child process running that command
T outputHandler({bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Reverts one or more commits in the working copy. The commit can be any regular commit-ish value (hash, name or offset such as HEAD~2) or a range of commits (eg: master~5..master~2). When supplied the options argument contain any options accepted by git-revert.
T revert(String commit, {List<String> options, bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Removes any number of files from source control
T rm(List<String> files, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Removes files from source control but leaves them on disk
T rmKeepLocal(List<String> files, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Stash the working directory, optional first argument can be an array of string arguments or options object to pass to the git stash command.
T stash({List<String> options, bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Retrieves the stash list, optional first argument can be an object specifying options.splitter to override the default value of ;;;;, alternatively options can be a set of arguments as supported by the git stash list command.
T stashList(List<String> options, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Runs any supported git tag commands with arguments passed as an array of strings
T tag(List<String> options, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// List all tags, use the optional options object to set any options allows by the git tag command. Tags will be sorted by semantic version number by default, for git versions 2.7 and above, use the --sort option to set a custom sort.
T tags({List<String> options, bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Show various types of objects, for example the file content at a certain commit. options is the single value string or array of string commands you want to run
T show(List<String> options, {bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// git version
T version({bool skipOnError = false, HandlerFunction handlerFn, bool showOutput});

/// Adds all files to be under source control, tracked and untracked
T status({bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput});

/// Adds all files to be under source control, tracked and untracked
T addAll({bool? skipOnError, HandlerFunction? handlerFn, bool? showOutput});
*/
}
