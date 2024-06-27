import 'package:ts_logger/ts_logger.dart';

void main() {
  TsLogger.instance.configure((config) {
    config.logLevels = LogLevel.values.toList();
    config.apiReportDuration = const Duration(minutes: 1);
    config.messageSpacing = 0;
    config.logMessageTime = true;
  });

  const String testMsg = 'This is a test message for testing purposes.';

  for (final level in LogLevel.values) {
    TsLogger.instance.logMessage(
      testMsg,
      level: level,
    );
  }
}
