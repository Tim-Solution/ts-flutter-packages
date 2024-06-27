// ignore_for_file: unused_field, unnecessary_getters_setters

import 'package:ts_logger/ts_logger.dart';

class TsLoggerConfig {
  List<LogLevel> _logLevels = LogLevel.values.toList();
  Duration? _apiReportDuration;
  int _messageSpacing = 0;

  List<LogLevel> get logLevels => _logLevels;
  Duration? get apiReportDuration => _apiReportDuration;
  int get messageSpacing => _messageSpacing;

  /// If the [levels] is empty, no logs will be printed.
  set logLevels(List<LogLevel> levels) => _logLevels = levels;

  /// If the [duration] is null, reports will not be printed in debug console.
  /// Otherwise, reports will be printed in debug console periodically with
  /// the specified duration.
  set apiReportDuration(Duration? duration) => _apiReportDuration = duration;

  /// Message spacing means how many empty lines will be printed before and
  /// after the message.
  set messageSpacing(int spacing) => _messageSpacing = spacing;
}
