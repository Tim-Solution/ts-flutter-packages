library ts_logger;

import 'src/ts_logger/logger_config.dart';
import 'src/ts_logger/message_logger.dart';

export 'src/data/enums/log_level.dart';

class TsLogger with MessageLogger {
  TsLogger._();
  static TsLogger? _instance;

  /// Singleton instance of [TsLogger]. It's fully safe to use this instance
  /// everywhere in the app. It will not create new instance of [TsLogger]
  /// every time it's called, it will return the same instance.
  ///
  /// Note: It's fully safe to use this in production or any other environment.
  /// Everithing provided by [TsLogger] will only work in **`kDebugMode`**.
  static TsLogger get instance => _instance ??= TsLogger._();

  /// Configuration of [TsLogger]. It is safe to call this method multiple
  /// times and wherever you want in the app. Recommended to call this method
  /// in the main function of the app.
  ///
  /// Example:
  ///
  /// ```dart
  /// TsLogger.instance.config((config) {
  ///   config.logLevels = LogLevel.values.toList(); // All levels will be logged.
  ///   config.apiReportDuration = null; // Null means disable;
  ///   // Check other configuration options. Every configuration is described.
  /// });
  /// ```
  void configure(void Function(TsLoggerConfig config) callback) {
    callback(TsLoggerConfig.instance);
  }
}
