import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:ts_logger/src/constants/colors.dart';
import 'package:ts_logger/src/core/message_logger_config.dart';
import 'package:ts_logger/src/extensions/color_extension.dart';
import 'package:ts_logger/src/helpers/datetime_helper.dart';
import 'package:ts_logger/src/helpers/log_helper.dart';
import 'package:ts_logger/ts_logger.dart';

mixin MessageLogger {
  /// Logs message with colorized text. Useful for any kind of messages.
  void logColorizedMessage({
    required String message,
    required Color color,
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;
    final logTime = MessageLoggerConfig.instance.logMessageTime;
    LogHelper.logMessage(
      '${color.toAnsi}$message'
      '${(logTime || file != null || function != null || stackTrace != null) ? '\n${TsColors.black}·\n${TsColors.grey}Aditional info:' : ''}'
      '${logTime ? '\n${TsColors.grey}⏰ Time: ${DateTimeHelper.getReadableDateTime(DateTime.now())}' : ''}'
      '${file != null ? '\n${TsColors.grey}📁 File: $file' : ''}'
      '${function != null ? '\n${TsColors.grey}🔧 Function: $function' : ''}'
      '${stackTrace != null ? '\n${TsColors.grey}🔍 Stack trace:\n$stackTrace' : ''}'
      '${(logTime || file != null || function != null || stackTrace != null) ? '${TsColors.black}\n·' : ''}',
      spacing: MessageLoggerConfig.instance.messageSpacing,
    );
  }

  /// Log message with level label.
  ///
  /// If you want just colorized message, use [logColorizedMessage] method.
  void logMessage(
    String message, {
    required LogLevel level,
    String? file,
    String? function,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;
    if (MessageLoggerConfig.instance.logLevels.contains(level)) {
      final logTime = MessageLoggerConfig.instance.logMessageTime;
      final colorize = MessageLoggerConfig.instance.colorizeLogs;
      LogHelper.logMessage(
        '${level.emoji} '
        '${level.ansiColor}[${level.readableName}]'
        '${colorize ? '' : TsColors.white} - $message'
        '${(logTime || file != null || function != null || stackTrace != null) ? '\n${TsColors.black}·\n${TsColors.grey}Aditional info:' : ''}'
        '${logTime ? '\n${TsColors.grey}⏰ Time: ${DateTimeHelper.getReadableDateTime(DateTime.now())}' : ''}'
        '${file != null ? '\n${TsColors.grey}📁 File: $file' : ''}'
        '${function != null ? '\n${TsColors.grey}🔧 Function: $function' : ''}'
        '${stackTrace != null ? '\n${TsColors.grey}🔍 Stack trace:\n$stackTrace' : ''}'
        '${(logTime || file != null || function != null || stackTrace != null) ? '${TsColors.black}\n·' : ''}',
        spacing: MessageLoggerConfig.instance.messageSpacing,
      );
    }
  }

  /// Log `🐛 [Debug]` message.
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

  /// Log `📄 [Info]` message.
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

  /// Log `⚠️ [Warning]` message.
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

  /// Log `⛔️ [Error]` message.
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

  /// Log `💀 [Fatal]` message.
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

  /// Log `🔍 [Verbose]` message.
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

  /// Log `🚨 [Critical]` message.
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
