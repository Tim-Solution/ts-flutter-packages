library ts_logger;

import 'package:dio/dio.dart';
import 'package:get/get_connect/connect.dart';
import 'package:ts_logger/src/core/api_logger_config.dart';
import 'package:ts_logger/src/ts_logger/middlewares/dio_middleware.dart';
import 'package:ts_logger/src/ts_logger/middlewares/get_connect_middleware.dart';

import 'src/core/message_logger_config.dart';
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
  void configure(
    void Function(
      MessageLoggerConfig messageLoggerConfig,
      ApiLoggerConfig apiLoggerConfig,
    ) callback,
  ) {
    callback(
      MessageLoggerConfig.instance,
      ApiLoggerConfig.instance,
    );
  }

  /// Activate logger for [GetHttpClient] client. It will log all requests and
  /// responses of the client.
  ///
  /// If clientId is already activated, nothing will happen. Usefull when you
  /// have multiple clients.
  ///
  /// Note:
  /// - [clientId] cannot be empty.
  /// - [clientId] cannot be longer than 30 characters.
  ///
  /// **Warning note:**
  /// - You maybe will not see logs in the debug console if device does not have
  /// internet connection. It's because of the way how [GetConnect] works.
  void activateGetConnectLogger(
    GetHttpClient client, {
    String clientId = 'GetConnectClient 0',
  }) {
    GetConnectMiddleware.instance.activate(client, clientId: clientId);
  }

  /// Activate logger for [Dio] client. It will log all requests and responses
  /// of the client.
  ///
  /// If clientId is already activated, nothing will happen. Usefull when you
  /// have multiple clients.
  ///
  /// Note:
  /// - [clientId] cannot be empty.
  /// - [clientId] cannot be longer than 30 characters.
  ///
  /// **Warning note:**
  /// - You maybe will not see response body in the debug console if device does
  /// not have internet connection. It's because of the way how [Dio] works.
  /// Status code will be 0.
  void activateDioLogger(
    Dio client, {
    String clientId = 'DioClient 0',
  }) {
    DioMiddleware.instance.activate(client, clientId: clientId);
  }
}
