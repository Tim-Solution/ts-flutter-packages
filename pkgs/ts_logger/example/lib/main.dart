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
    messageLoggerConfig.colorizeLogs = false;
    // other configurations here

    apiLoggerConfig.logRequestBody = true;
    apiLoggerConfig.logRequestQueryParams = true;
    apiLoggerConfig.logRequestHeaders = true;
    apiLoggerConfig.ignoreRequestHeaders = ['Authorization'];
    apiLoggerConfig.reportInterval = null;
    // other configurations here
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

  await getConnectClient.get(
    'https://jsonplaceholder.typicode.com/comments?postId=2',
    headers: {
      'content-type': 'application/json',
      'token': 'test',
    },
  );
  await getConnectClient.get(
    'https://jsonplaceholder.typicode.com/comments?postId=1',
    headers: {
      'Authorization': 'Bearer testToken',
    },
  );

  for (int i = 0; i < 5; i++) {
    dioClient.get(
      'https://jsonplaceholder.typicode.com/posts/1',
    );
  }
}
