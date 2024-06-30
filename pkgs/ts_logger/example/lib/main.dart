import 'package:flutter/material.dart';

import 'package:get/get.dart';
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

  final client = GetConnect();

  TsLogger.instance.activateGetConnectLogger(
    client.httpClient,
  );

  client.get('https://jsonplaceholder.typicode.com/users');
  client.get('https://jsonplaceholder.typicode.com/comments?postId=1');
}
