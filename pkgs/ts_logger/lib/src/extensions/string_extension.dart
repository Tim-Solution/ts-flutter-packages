import 'package:ts_logger/src/constants/colors.dart';
import 'package:ts_logger/ts_logger.dart';

extension StringExtension on String {
  TsLogger get _logger => TsLogger.instance;

  String addRowSpacing() {
    if (_logger.config.messageSpacing > 0) {
      final l = '${TsLoggerColors.black}·\n' * _logger.config.messageSpacing;
      final t = '${TsLoggerColors.black}\n·' * _logger.config.messageSpacing;
      return '$l$this$t';
    } else {
      return this;
    }
  }
}
