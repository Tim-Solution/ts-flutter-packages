import 'package:flutter/material.dart';

import 'package:dio/dio.dart' as d;
import 'package:get/get.dart' as g;
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

  FlutterError.onError = (details) {
    TsLogger.instance.onFlutterError(details);
  };

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

  final getConnectClient = g.GetConnect();
  final dioClient = d.Dio();

  TsLogger.instance.activateGetConnectLogger(getConnectClient.httpClient);
  TsLogger.instance.activateDioLogger(dioClient);

  getConnectClient.get(
    'https://jsonplaceholder.typicode.com/users',
  );
  getConnectClient.get(
    'https://jsonplaceholder.typicode.com/comments?postId=1',
  );
  dioClient.get(
    'https://jsonplaceholder.typicode.com/posts/1',
  );
  dioClient.get(
    'https://jsonplaceholder.typicode.com/posts/2',
  );
}
