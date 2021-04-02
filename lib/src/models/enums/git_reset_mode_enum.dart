enum GitResetModeEnum { mixed, soft, hard, merge, keep, file }

extension GitResetExt on GitResetModeEnum {
  String get value {
    switch (this) {
      case GitResetModeEnum.mixed:
        return '--mixed';
      case GitResetModeEnum.hard:
        return '--hard';
      case GitResetModeEnum.merge:
        return '--merge';
      case GitResetModeEnum.keep:
        return '--keep';
      case GitResetModeEnum.file:
        return '--';
      default:
        return '--soft';
    }
  }
}
