import 'package:ts_logger/ts_logger.dart';

void main() {
  TsLogger.instance.configure((config) {
    config.logLevels = LogLevel.values.toList();
    config.apiReportDuration = const Duration(minutes: 1);
    config.messageSpacing = 0;
  });

  const String testMsg = 'This is a test message for testing purposes.';

  TsLogger.instance.logFatal(testMsg);
  TsLogger.instance.logError(testMsg);
  TsLogger.instance.logWarning(testMsg);
  TsLogger.instance.logInfo(testMsg);
  TsLogger.instance.logDebug(testMsg);
  TsLogger.instance.logVerbose(testMsg);
  TsLogger.instance.logCritical(testMsg);

  TsLogger.instance.configure((config) {
    config.logLevels = [LogLevel.critical, LogLevel.error, LogLevel.fatal];
  });

  TsLogger.instance.logFatal(testMsg);
  TsLogger.instance.logError(testMsg);
  TsLogger.instance.logWarning(testMsg);
  TsLogger.instance.logInfo(testMsg);
  TsLogger.instance.logDebug(testMsg);
  TsLogger.instance.logVerbose(testMsg);
  TsLogger.instance.logCritical(testMsg);
}
