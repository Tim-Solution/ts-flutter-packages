import 'package:ts_logger/src/constants/colors.dart';
import 'package:ts_logger/src/ts_logger/logger_config.dart';

extension StringExtension on String {
  TsLoggerConfig get _config => TsLoggerConfig.instance;

  String addRowSpacing() {
    if (_config.messageSpacing > 0) {
      final l = '${TsLoggerColors.black}·\n' * _config.messageSpacing;
      final t = '${TsLoggerColors.black}\n·' * _config.messageSpacing;
      return '$l$this$t';
    } else {
      return this;
    }
  }
}
