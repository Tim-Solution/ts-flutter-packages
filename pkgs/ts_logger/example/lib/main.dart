import 'package:flutter/material.dart';

import 'package:ts_logger/ts_logger.dart';

void main() async {
  TsLogger.instance.configure((
    messageLoggerConfig,
    apiLoggerConfig,
  ) {
    messageLoggerConfig.logLevels = LogLevel.values.toList();
    messageLoggerConfig.messageSpacing = 0;
    messageLoggerConfig.logMessageTime = true;
    messageLoggerConfig.colorizeLogs = false;
    //
    apiLoggerConfig.logRequestBody = true;
    apiLoggerConfig.logRequestQueryParams = true;
  });

  TsLogger.instance.logColorizedMessage(
    message: 'This is colorized message for testing purposes.',
    color: Colors.cyan,
  );
  for (final level in LogLevel.values) {
    TsLogger.instance.logMessage(
      'This is dummy message for testing purposes.',
      level: level,
    );
  }

  /// Success
  await ApiLogger.log(
    requestBody: {'key': 'value', 'key2': 'value2', 'key3': null}.toString(),
    responseBody: {'key': 'value', 'key2': 'value2'}.toString(),
    statusCode: 200,
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(seconds: 1, milliseconds: 125)),
    method: 'GET',
    uri: Uri.parse('https://example.com/api/v1/testing?query=param'),
    requestNumber: 1,
  );

  /// Failure
  await ApiLogger.log(
    requestBody: {'key': 'value', 'key2': 'value'}.toString(),
    responseBody: {'key': 'value', 'key2': 'value'}.toString(),
    statusCode: 400,
    startTime: DateTime.now(),
    endTime:
        DateTime.now().add(const Duration(seconds: 1, milliseconds: 12465)),
    method: 'POST',
    uri: Uri.parse('https://example.com/api/v1/testing'),
    requestNumber: 2,
  );
}
