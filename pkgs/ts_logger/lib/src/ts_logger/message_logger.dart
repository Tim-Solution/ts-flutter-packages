import 'package:ts_logger/src/constants/colors.dart';
import 'package:ts_logger/src/helpers/log_helper.dart';
import 'package:ts_logger/ts_logger.dart';

mixin MessageLogger {
  void logMessage(
    String message, {
    required LogLevel level,
  }) {
    final logLevel = TsLogger.instance.config.logLevels;
    if (logLevel.contains(level)) {
      LogHelper.logMessage(
        '${level.emoji} '
        '${level.ansiColor}[${level.upperCaseName}]'
        '${TsLoggerColors.white} - $message',
      );
    }
  }

  void logDebug(String message) {
    logMessage(message, level: LogLevel.debug);
  }

  void logInfo(String message) {
    logMessage(message, level: LogLevel.info);
  }

  void logWarning(String message) {
    logMessage(message, level: LogLevel.warning);
  }

  void logError(String message) {
    logMessage(message, level: LogLevel.error);
  }

  void logVerbose(String message) {
    logMessage(message, level: LogLevel.verbose);
  }

  void logCritical(String message) {
    logMessage(message, level: LogLevel.critical);
  }

  void logFatal(String message) {
    logMessage(message, level: LogLevel.fatal);
  }
}
