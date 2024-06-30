import 'package:ts_logger/src/constants/colors.dart';
import 'package:ts_logger/src/core/message_logger_config.dart';

extension StringExtension on String {
  MessageLoggerConfig get _config => MessageLoggerConfig.instance;

  /// Based on configuration, it will add empty lines before and after the message.
  String addRowSpacing() {
    if (_config.messageSpacing > 0) {
      final leading = '${TsLoggerColors.black}·\n' * _config.messageSpacing;
      final trailing = '${TsLoggerColors.black}\n·' * _config.messageSpacing;
      return '$leading$this$trailing';
    } else {
      return this;
    }
  }
}
