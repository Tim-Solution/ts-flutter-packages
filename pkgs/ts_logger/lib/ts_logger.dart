library ts_logger;

import 'package:ts_logger/src/ts_logger/message_logger.dart';

import 'src/ts_logger/logger_config.dart';

export 'src/data/models/api_logger_config.dart';
export 'src/data/enums/log_level.dart';

class TsLogger with MessageLogger {
  TsLogger._intern();

  static TsLogger? _instance;
  final TsLoggerConfig _config = TsLoggerConfig();

  /// Singleton instance of [TsLogger]. It's fully safe to use this instance
  /// everywhere in the app. It will not create new instance of [TsLogger]
  /// every time it's called, but it will return the same instance.
  static TsLogger get instance => _instance ??= TsLogger._intern();

  /// Configuration of [TsLogger].
  TsLoggerConfig get config => _config;

  /// Configuration of [TsLogger].
  ///
  /// Example:
  ///
  /// ```dart
  /// TsLogger.instance.config((config) {
  ///   config.logLevels = LogLevel.values.toList(); // All levels will be logged.
  ///   config.apiReportDuration = null; // Null means disable;
  /// });
  /// ```
  void configure(void Function(TsLoggerConfig config) callback) {
    callback(_config);
  }
}
