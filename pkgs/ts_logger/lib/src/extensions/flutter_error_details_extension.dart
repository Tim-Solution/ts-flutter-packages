// ignore_for_file: unnecessary_this

import 'package:flutter/foundation.dart';

import 'package:ts_logger/ts_logger.dart';

extension FlutterErrorDetailsExtension on FlutterErrorDetails {
  LogLevel get getTsLogLevel {
    final exception = this.exception;
    final exceptionString = exception.toString();
    final stackTrace = this.stack.toString();

    if (exception is AssertionError) {
      return LogLevel.fatal;
    } else if (exception is NoSuchMethodError) {
      return LogLevel.critical;
    } else if (exception is TypeError) {
      return LogLevel.error;
    } else if (exceptionString.contains('HttpException') ||
        exceptionString.contains('SocketException') ||
        exceptionString.contains('TimeoutException') ||
        exceptionString.contains('NetworkException') ||
        exceptionString.contains('PlatformException') ||
        exceptionString.contains('FileSystemException') ||
        exceptionString.contains('DatabaseException') ||
        exceptionString.contains('FlutterError') ||
        exceptionString.contains('Compress') ||
        exceptionString.contains('Counted') ||
        exceptionString.contains('DioError') ||
        exceptionString.contains('OverflowException')) {
      return LogLevel.warning;
    } else if (stackTrace.contains('verbose')) {
      return LogLevel.verbose;
    } else if (stackTrace.contains('debug')) {
      return LogLevel.debug;
    } else if (this.library != null && this.library!.contains('flutter')) {
      return LogLevel.info;
    } else {
      return LogLevel.debug;
    }
  }
}
