import 'package:flutter/material.dart';

import 'package:ts_logger/ts_logger.dart';

void main() {
  TsLogger.instance.configure((config) {
    config.logLevels = LogLevel.values.toList();
    config.apiReportDuration = const Duration(minutes: 1);
    config.messageSpacing = 0;
    config.logMessageTime = false;
    config.colorizeLogs = false;
  });

  const String testMsg = 'This is dummy message for testing purposes.';

  TsLogger.instance.logColorizedMessage(
    message: 'This is colorized message for testing purposes.',
    color: Colors.cyan,
  );
  for (final level in LogLevel.values) {
    TsLogger.instance.logMessage(
      testMsg,
      level: level,
    );
  }
}
