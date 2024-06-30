import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:get/get_connect/http/src/http.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ts_logger/src/core/api_logger_config.dart';
import 'package:ts_logger/src/extensions/get_connect_extension.dart';
import 'package:ts_logger/src/ts_logger/api_logger.dart';
import 'package:ts_logger/ts_logger.dart';

class GetConnectMiddleware {
  GetConnectMiddleware._();

  static GetConnectMiddleware? _instance;
  static GetConnectMiddleware get instance {
    return _instance ??= GetConnectMiddleware._();
  }

  int _requestNumber = 0;
  final List<String> _initializedClients = [];
  final Map<String, Map<int, Map<String, dynamic>>> _requestsSha = {};
  final Map<String, int> _successfulRequests = {};
  final Map<String, int> _failedRequests = {};

  int _totalSuccessfulRequests(String clientId) {
    return _successfulRequests[clientId] ?? 0;
  }

  int _totalFailedRequests(String clientId) {
    return _failedRequests[clientId] ?? 0;
  }

  int _totalRequests(String clientId) {
    return _totalSuccessfulRequests(clientId) + _totalFailedRequests(clientId);
  }

  void activate(
    GetHttpClient client, {
    String clientId = 'GetConnectClient 0',
  }) {
    assert(
      clientId.isNotEmpty,
      'Client ID cannot be empty.',
    );
    assert(
      clientId.length <= 30,
      'Client ID cannot be longer than 30 characters.',
    );
    if (!kDebugMode) return;
    if (_initializedClients.contains(clientId)) {
      TsLogger.instance.logWarning(
        'Client ID: $clientId is already activated.',
      );
      return;
    }

    _initializedClients.add(clientId);

    client.addRequestModifier<dynamic>((request) {
      _requestModifier(request, clientId);
      return request;
    });

    client.addResponseModifier<dynamic>((request, response) {
      _responseModifier(request, response, clientId);
      return response;
    });

    final interval = ApiLoggerConfig.instance.reportInterval;
    if (interval != null) {
      Timer.periodic(interval, (_) {
        ApiLogger.apiReport(
          clientId: clientId,
          totalRequests: _totalRequests(clientId),
          successfulRequests: _totalSuccessfulRequests(clientId),
          failedRequests: _totalFailedRequests(clientId),
        );
      });
    }
  }

  void _requestModifier(
    Request request,
    String clientId,
  ) {
    final hashCode = request.hashCode;
    _requestsSha[clientId] ??= {};
    _successfulRequests[clientId] = 0;
    _failedRequests[clientId] = 0;
    _requestsSha[clientId]![hashCode] = {};
    _requestsSha[clientId]![hashCode]!['requestNumber'] = _requestNumber;
    _requestsSha[clientId]![hashCode]!['startTime'] = DateTime.now();
    _requestNumber++;
  }

  Future<void> _responseModifier(
    Request request,
    Response response,
    String clientId,
  ) async {
    final requestNumber =
        _requestsSha[clientId]![request.hashCode]?['requestNumber'] as int;
    final startTime =
        _requestsSha[clientId]![request.hashCode]!['startTime'] as DateTime;
    final endTime = DateTime.now();
    final method = request.method;
    final uri = request.url;
    final requestBody = await request.getBodyString();
    final responseBody = response.body?.toString() ?? '';
    final statusCode = response.statusCode;

    if (ApiLoggerConfig.instance.successStatusCodes.contains(statusCode)) {
      _successfulRequests[clientId] = _totalSuccessfulRequests(clientId) + 1;
    } else {
      _failedRequests[clientId] = _totalFailedRequests(clientId) + 1;
    }

    await ApiLogger.log(
      clientId: clientId,
      requestBody: requestBody,
      responseBody: responseBody,
      method: method,
      uri: uri,
      statusCode: statusCode,
      startTime: startTime,
      endTime: endTime,
      requestNumber: requestNumber,
    );
  }
}
