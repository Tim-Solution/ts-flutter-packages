import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:ts_logger/src/ts_logger/api_logger.dart';
import 'package:ts_logger/ts_logger.dart';

class DioMiddleware {
  DioMiddleware._();

  static DioMiddleware? _instance;
  static DioMiddleware get instance {
    return _instance ??= DioMiddleware._();
  }

  int _requestNumber = 0;
  final List<String> _initializedClients = [];
  // Map<clientId, Map<requestHashCode, Map<key, value>>>
  final Map<String, Map<int, Map<String, dynamic>>> _requestsSha = {};

  void activate(
    Dio client, {
    String clientId = '0',
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

    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _requestModifier(options, clientId);
          handler.next(options);
        },
        onResponse: (response, handler) {
          _responseModifier(response.requestOptions, response, clientId);
          handler.next(response);
        },
        onError: (DioException e, handler) {
          _responseModifier(e.requestOptions, e.response, clientId);
          handler.next(e);
        },
      ),
    );
  }

  void _requestModifier(
    RequestOptions request,
    String clientId,
  ) {
    final hashCode = request.hashCode;
    _requestsSha[clientId] ??= {};
    _requestsSha[clientId]![hashCode] = {};
    _requestsSha[clientId]![hashCode]!['requestNumber'] = _requestNumber;
    _requestsSha[clientId]![hashCode]!['startTime'] = DateTime.now();
    _requestNumber++;
  }

  Future<void> _responseModifier(
    RequestOptions request,
    Response? response,
    String clientId,
  ) async {
    final hashCode = request.hashCode;
    final requestNumber =
        _requestsSha[clientId]?[hashCode]?['requestNumber'] as int?;
    final startTime =
        _requestsSha[clientId]?[hashCode]?['startTime'] as DateTime?;
    final endTime = DateTime.now();
    final method = request.method;
    final uri = request.uri;
    final requestBody = request.data.toString();
    final responseBody = response?.data?.toString() ?? '';
    final statusCode = response?.statusCode ?? 0;

    if (requestNumber != null && startTime != null) {
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
}
