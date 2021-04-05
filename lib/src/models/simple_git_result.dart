import 'package:simple_process/simple_process.dart';

class SimpleGitResult extends SimpleProcessResult {
  SimpleGitResult({processResult, processException})
      : super(
          processResult: processResult,
        );
}
