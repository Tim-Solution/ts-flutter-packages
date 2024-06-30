import 'package:flutter/material.dart';

import 'package:ts_logger/ts_logger.dart';

void main() {
  TsLogger.instance.configure((
    messageLoggerConfig,
    apiLoggerConfig,
  ) {
    messageLoggerConfig.logLevels = LogLevel.values.toList();
    messageLoggerConfig.messageSpacing = 0;
    messageLoggerConfig.logMessageTime = false;
    messageLoggerConfig.colorizeLogs = false;
  });

  TsLogger.instance.logColorizedMessage(
    message: 'This is colorized message for testing purposes.',
    color: Colors.cyan,
  );
  for (final level in LogLevel.values) {
    TsLogger.instance.logMessage(
      'This is dummy message for testing purposes.',
      level: level,
    );
  }
}
