import 'package:flutter/foundation.dart';

import 'package:ts_logger/src/constants/colors.dart';
import 'package:ts_logger/src/helpers/datetime_helper.dart';
import 'package:ts_logger/src/helpers/log_helper.dart';
import 'package:ts_logger/ts_logger.dart';

mixin MessageLogger {
  void logMessage(
    String message, {
    required LogLevel level,
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;
    if (TsLogger.instance.config.logLevels.contains(level)) {
      final logTime = TsLogger.instance.config.logMessageTime;
      LogHelper.logMessage(
        '${level.emoji} '
        '${level.ansiColor}[${level.readableName}]'
        '${TsLoggerColors.white} - $message'
        '${(logTime || file != null || function != null || stackTrace != null) ? '\n${TsLoggerColors.black}·\n${TsLoggerColors.grey}Aditional info:' : ''}'
        '${logTime ? '\n${TsLoggerColors.grey}⏰ Time: ${DateTimeHelper.getReadableDateTime(DateTime.now())}' : ''}'
        '${file != null ? '\n${TsLoggerColors.grey}📁 File: $file' : ''}'
        '${function != null ? '\n${TsLoggerColors.grey}🔧 Function: $function' : ''}'
        '${stackTrace != null ? '\n${TsLoggerColors.grey}🔍 Stack trace:\n$stackTrace' : ''}'
        '${(logTime || file != null || function != null || stackTrace != null) ? '${TsLoggerColors.black}\n·' : ''}',
      );
    }
  }

  void logDebug(
    String message, {
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    logMessage(
      message,
      level: LogLevel.debug,
      file: file,
      function: function,
      stackTrace: stackTrace,
    );
  }

  void logInfo(
    String message, {
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    logMessage(
      message,
      level: LogLevel.info,
      file: file,
      function: function,
      stackTrace: stackTrace,
    );
  }

  void logWarning(
    String message, {
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    logMessage(
      message,
      level: LogLevel.warning,
      file: file,
      function: function,
      stackTrace: stackTrace,
    );
  }

  void logError(
    String message, {
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    logMessage(
      message,
      level: LogLevel.error,
      file: file,
      function: function,
      stackTrace: stackTrace,
    );
  }

  void logFatal(
    String message, {
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    logMessage(
      message,
      level: LogLevel.fatal,
      file: file,
      function: function,
      stackTrace: stackTrace,
    );
  }

  void logVerbose(
    String message, {
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    logMessage(
      message,
      level: LogLevel.verbose,
      file: file,
      function: function,
      stackTrace: stackTrace,
    );
  }

  void logCritical(
    String message, {
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    logMessage(
      message,
      level: LogLevel.critical,
      file: file,
      function: function,
      stackTrace: stackTrace,
    );
  }
}
