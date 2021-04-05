[![Plugin](https://img.shields.io/badge/library-pub.dev-blue)](https://pub.dev/packages/simple_git) &nbsp; [![Example](https://img.shields.io/badge/example-ex-success)](https://pub.dev/packages/simple_git/example)

# Simple Git

A lightweight interface for running `git` commands in any [dart](https://dart.dev/) application.

### Simple git package is inspired in nodejs simple-git
#### This package is not be intended to be a exact clone of simple-git(node js), improvements and new features are welcome!

## Installation

Add as dependency in pubspec.yaml
```yaml
  dependencies:
    simple_git: 0.1.2
```

## System Dependencies

Requires [git](https://git-scm.com/downloads) to be installed and that it can be called using the command `git`.

### Usage

Include into your dart app using:

```dart
import 'package:simple_git/simple_git.dart';

var simpleGit = SimpleGit(SimpleProcessOptions());
```

### Configuration

Configure each `simple_git` instance with a properties object passed to the `SimpleGit` constructor:

```dart
import 'package:simple_git/simple_git.dart';

var options = SimpleProcessOptions();

// or

// All fields are optionals
  var options = SimpleProcessOptions(
    baseDir: Directory.current.path, // working directory for `git` commands to run in
    showOutput: true, // this make all output be printed on terminal (default = false)
    binary: 'git',
    config: 'http.proxy=someproxy',
    maxConcurrentProcesses: 6,
    runInShell: true,
  );
```
All configuration properties are optional, the default values are shown in the example above.

### Per-command Configuration

To prefix the commands run by `simple_git` with custom configuration not saved in the git config (ie: using the
`-c` command) supply a `config` option to the instance builder:

```dart
// configure the instance with a custom configuration property
var options = SimpleProcessOptions(
  config: 'http.proxy=someproxy'
);

// any command executed will be prefixed with this config
// runs: git -c http.proxy=someproxy pull
simpleGit.pull();
```

### The default SimpleGit is "sync", but you can use the async version `SimpleGitAsync`.

### Using task Future

You can chaining commands using cascade operators on Sync version or run all commands at same time using async.
Or await the `Future` get finished

```dart
// Sync
simpleGitSync..init()..addRemote('origin', '...remote.git');

// Async with await
await simpleGitAsync.init();
await simpleGitAsync.addRemote('origin', '...remote.git')

// Async at same time (Future.await is possible also)
simpleGitAsync..init()..addRemote('origin', '...remote.git');
``` 

### Catching errors  `GitException`

To catch errors in async code, either wrap the whole chain in a try/catch:

```dart
try {
    await simpleGitAsync.init();
    await simpleGitAsync.addRemote(name, repoUrl);
} on GitException catch(gitException) { /* handle all git errors here */ }
catch (e) { /* handle all other kind of errors here */ }
```

or catch individual steps to permit the main chain to carry on executing rather than
jumping to the final `catch` on the first error:

```dart
// Async
    await simpleGitAsync.init().catchError(gitException); // GitException
```

```dart
  // Sync
  
  // handle the error manually
  var result = simpleGit.init(skipOnError: true); // Not throw error if `skipOnError: true`
  if (result.exitCode != 0) {
    print('Error: ' + result.stderr);
    // return
  }
```

### Using task callbacks `HandlerFunction`
```dart
simpleGit.init(
  handlerFn: (result) { // ProcessResult result
      // always fired! with error or not
  }
);
``` 

### Task Responses `ProcessResult`
Whether using a trailing callback, sync or async commands, tasks either return the `ProcessResult` or `Future<ProcessResult>` response.

### Take a look in the example project folder for more samples.

### 🛑   API NOT READY YET - TODO:

| API | What it does |
|-----|--------------|
| `.add([fileA, ...], handlerFn)` | adds one or more files to be under source control |
| `.addAnnotatedTag(tagName, tagMessage, handlerFn)` | adds an annotated tag to the head of the current branch |
| `.addTag(name, handlerFn)` | adds a lightweight tag to the head of the current branch |
| `.catFile(options[, handlerFn])` | generate `cat-file` detail, `options` should be an array of strings as supported arguments to the [cat-file](https://git-scm.com/docs/git-cat-file) command |
| `.checkIgnore([filepath, ...], handlerFn)` | checks if filepath excluded by .gitignore rules |
| `.clearQueue()` | immediately clears the queue of pending tasks (note: any command currently in progress will still call its completion callback) |
| `.commit(message, handlerFn)` | commits changes in the current working directory with the supplied message where the message can be either a single string or array of strings to be passed as separate arguments (the `git` command line interface converts these to be separated by double line breaks) |
| `.commit(message, [fileA, ...], options, handlerFn)` | commits changes on the named files with the supplied message, when supplied, the optional options object can contain any other parameters to pass to the commit command, setting the value of the property to be a string will add `name=value` to the command string, setting any other type of value will result in just the key from the object being passed (ie: just `name`), an example of setting the author is below |
| `.customBinary(gitPath)` | sets the command to use to reference git, allows for using a git binary not available on the path environment variable |
| `.cwd(workingDirectory)` |  Sets the current working directory for all commands after this step in the chain |
| `.diff(options, handlerFn)` | get the diff of the current repo compared to the last commit with a set of options supplied as a string |
| `.diff(handlerFn)` | get the diff for all file in the current repo compared to the last commit |
| `.diffSummary(handlerFn)` | gets a summary of the diff for files in the repo, uses the `git diff --stat` format to calculate changes. Handler is called with a nullable error object and an instance of the [DiffSummary](src/lib/responses/DiffSummary.js) |
| `.diffSummary(options, handlerFn)` | includes options in the call to `diff --stat options` and returns a [DiffSummary](src/lib/responses/DiffSummary.js) |
| `.env(name, value)` | Set environment variables to be passed to the spawned child processes, [see usage in detail below](#environment-variables). |
| `.exec(handlerFn)` | calls a simple function in the current step |
| `.fetch([options, ] handlerFn)` | update the local working copy database with changes from the default remote repo and branch, when supplied the options argument can be a standard [options object](#how-to-specify-options) either an array of string commands as supported by the [git fetch](https://git-scm.com/docs/git-fetch). |
| `.fetch(remote, branch, handlerFn)` | update the local working copy database with changes from a remote repo |
| `.fetch(handlerFn)` | update the local working copy database with changes from the default remote repo and branch |
| `.log([options], handlerFn)` | list commits between `options.from` and `options.to` tags or branch (if not specified will show all history). Additionally you can provide `options.file`, which is the path to a file in your repository. Then only this file will be considered. `options.symmetric` allows you to specify whether you want to use [symmetric revision range](https://git-scm.com/docs/gitrevisions#_dotted_range_notations) (To be compatible, by default, its value is true). For any other set of options, supply `options` as an array of strings to be appended to the `git log` command. To use a custom splitter in the log format, set `options.splitter` to be the string the log should be split on. Set `options.multiLine` to true to include a multi-line body in the output format. Options can also be supplied as a standard [options](#how-to-specify-options) object for adding custom properties supported by the [git log](https://git-scm.com/docs/git-log) command. |
| `.outputHandler(handlerFn)` | attaches a handler that will be called with the name of the command being run and the `stdout` and `stderr` [readable streams](https://nodejs.org/api/stream.html#stream_class_stream_readable) created by the [child process](https://nodejs.org/api/child_process.html#child_process_class_childprocess) running that command |
| `.raw(args[, handlerFn])` | Execute any arbitrary array of commands supported by the underlying git binary. When the git process returns a non-zero signal on exit and it printed something to `stderr`, the commmand will be treated as an error, otherwise treated as a success. |
| `.rebase([options,] handlerFn)` | Rebases the repo, `options` should be supplied as an array of string parameters supported by the [git rebase](https://git-scm.com/docs/git-rebase) command, or an object of options (see details below for option formats). |
| `.revert(commit [, options [, handlerFn]])` | reverts one or more commits in the working copy. The commit can be any regular commit-ish value (hash, name or offset such as `HEAD~2`) or a range of commits (eg: `master~5..master~2`). When supplied the [options](#how-to-specify-options) argument contain any options accepted by [git-revert](https://git-scm.com/docs/git-revert). |
| `.rm([fileA, ...], handlerFn)` | removes any number of files from source control |
| `.rmKeepLocal([fileA, ...], handlerFn)` | removes files from source control but leaves them on disk |
| `.stash([options, ][ handlerFn])` | Stash the working directory, optional first argument can be an array of string arguments or [options](#how-to-specify-options) object to pass to the [git stash](https://git-scm.com/docs/git-stash) command. |
| `.stashList([options, ][handlerFn])` | Retrieves the stash list, optional first argument can be an object specifying `options.splitter` to override the default value of `;;;;`, alternatively options can be a set of arguments as supported by the `git stash list` command. |
| `.tag(args[], handlerFn)` | Runs any supported [git tag](https://git-scm.com/docs/git-tag) commands with arguments passed as an array of strings . |
| `.tags([options, ] handlerFn)` | list all tags, use the optional [options](#how-to-specify-options) object to set any options allows by the [git tag](https://git-scm.com/docs/git-tag) command. Tags will be sorted by semantic version number by default, for git versions 2.7 and above, use the `--sort` option to set a custom sort. |
| `.show([options], handlerFn)` | Show various types of objects, for example the file content at a certain commit. `options` is the single value string or array of string commands you want to run |


#### ⚠️  Disclaimer: this is a work in progress, please consider to help improve this package and avoid to use it in production releases, since it doesn't ready for that.
#### Pull requests are welcome! If you can, please, contribute. Let's make this happen!