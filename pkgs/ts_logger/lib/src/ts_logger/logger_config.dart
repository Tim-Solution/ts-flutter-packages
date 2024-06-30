// ignore_for_file: unused_field, unnecessary_getters_setters

import 'package:ts_logger/ts_logger.dart';

class TsLoggerConfig {
  TsLoggerConfig._();

  static TsLoggerConfig? _instance;
  static TsLoggerConfig get instance => _instance ??= TsLoggerConfig._();

  List<LogLevel> _logLevels = LogLevel.values.toList();
  Duration? _apiReportDuration;
  int _messageSpacing = 0;
  bool _colorizeLogs = true;
  bool _logMessageTime = true;

  List<LogLevel> get logLevels => _logLevels;
  Duration? get apiReportDuration => _apiReportDuration;
  int get messageSpacing => _messageSpacing;
  bool get colorizeLogs => _colorizeLogs;
  bool get logMessageTime => _logMessageTime;

  /// If the [levels] is empty, no logs will be printed.
  set logLevels(List<LogLevel> levels) => _logLevels = levels;

  /// If the [duration] is null, reports will be disabled.
  ///
  /// If the [duration] is not null, reports will be printed every [duration].
  /// Reports means the information about the API call, like number of calls,
  /// success rate, etc.
  set apiReportDuration(Duration? duration) => _apiReportDuration = duration;

  /// Message spacing means how many empty lines will be printed before and
  /// after the message.
  set messageSpacing(int spacing) => _messageSpacing = spacing;

  /// If [colorize] is true, the logs will be colorized. Otherwise, only the
  /// level label will be colorized.
  set colorizeLogs(bool colorize) => _colorizeLogs = colorize;

  /// If [log] is true, the time will be printed with the message.
  set logMessageTime(bool log) => _logMessageTime = log;
}
