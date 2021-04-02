import 'dart:io';

extension ProcessResultExt on ProcessResult {
  List<String> get lines {
    try {
      return this
          .stdout
          .toString()
          .split('\n')
          .where((e) => e.trim().isNotEmpty)
          .toList();
    } catch (e) {
      return [];
    }
  }
}
