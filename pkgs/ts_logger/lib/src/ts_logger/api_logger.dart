import 'package:ts_logger/src/constants/colors.dart';
import 'package:ts_logger/src/core/api_logger_config.dart';
import 'package:ts_logger/src/extensions/string_extension.dart';
import 'package:ts_logger/src/helpers/datetime_helper.dart';
import 'package:ts_logger/src/helpers/log_helper.dart';
import 'package:ts_logger/src/helpers/string_helper.dart';

abstract class ApiLogger {
  ApiLogger._();

  static Future<void> apiReport({
    required String clientId,
    required int totalRequests,
    required int successfulRequests,
    required int failedRequests,
  }) async {
    final buffer = StringBuffer();
    buffer.write(
      '${TsColors.blueLight}📊 $clientId - REPORT\n'
      '${TsColors.black}·\n',
    );
    buffer.write(
      '📈 ${TsColors.white}Total requests: ${TsColors.cyan}$totalRequests\n',
    );
    buffer.write(
      '✅ ${TsColors.white}Successful requests: ${TsColors.green}$successfulRequests\n',
    );
    buffer.write(
      '❌ ${TsColors.white}Failed requests: ${TsColors.red}$failedRequests\n',
    );
    LogHelper.logMessage(
      buffer.toString(),
      spacing: ApiLoggerConfig.instance.messageSpacing,
    );
  }

  static Future<void> log({
    required String clientId,
    required String requestBody,
    required String responseBody,
    required String method,
    required Uri uri,
    required int? statusCode,
    required DateTime startTime,
    required DateTime endTime,
    required int requestNumber,
  }) async {
    final clientIdMsg = '${TsColors.grey} | Client ID: $clientId';

    final req = await _logRequest(
      body: requestBody,
      method: method,
      uri: uri,
      requestNumber: requestNumber,
      clientIdMsg: clientIdMsg,
    );

    final res = await _logResponse(
      body: responseBody,
      statusCode: statusCode,
      startTime: startTime,
      endTime: endTime,
      requestNumber: requestNumber,
      clientIdMsg: clientIdMsg,
    );

    LogHelper.logMessage(
      '$req$res',
      spacing: ApiLoggerConfig.instance.messageSpacing,
    );
  }

  /// Log request details.
  static Future<String> _logRequest({
    required String body,
    required String method,
    required Uri uri,
    required int requestNumber,
    String? clientIdMsg,
  }) async {
    final StringBuffer buffer = StringBuffer();

    buffer.write(
      '${TsColors.green}↑ REQUEST ↑ [$requestNumber] ${clientIdMsg ?? ''}'
      '\n'
      '${TsColors.black}·\n',
    );

    buffer.write(
      '🔗 ${TsColors.white}Endpoint(${StringHelper.colorizeApiMethod(method)}${TsColors.white}):'
      ' ${TsColors.cyan}${uri.path.isEmpty ? '/' : uri.path}'
      '\n',
    );

    if (ApiLoggerConfig.instance.logRequestQueryParams &&
        uri.queryParameters.isNotEmpty) {
      buffer.write(
        '🧩 ${TsColors.white}Query params${TsColors.grey}(${uri.queryParameters.length}}${TsColors.white}:'
        '\n',
      );

      uri.queryParameters.forEach((key, value) {
        buffer.write(
          '   ${TsColors.black}> ${TsColors.orange}$key${TsColors.grey}=${TsColors.cyan}$value${TsColors.grey},'
          '${uri.queryParameters.keys.last != key ? '\n' : ''}',
        );
      });
      buffer.write(
        ApiLoggerConfig.instance.logRequestBody && body.isNotEmpty ? '\n' : '',
      );
    }

    if (ApiLoggerConfig.instance.logRequestBody && body.isNotEmpty) {
      buffer.write(
        '📦 ${TsColors.white}Body: ${body.substringByLength(ApiLoggerConfig.instance.maxResponseLenghtForPrint).colorizeResponseBody()}',
      );
    }

    return buffer.toString();
  }

  static Future<String> _logResponse({
    required String body,
    required int? statusCode,
    required DateTime startTime,
    required DateTime endTime,
    required int requestNumber,
    String? clientIdMsg,
  }) async {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln('${TsColors.black}·\n');

    buffer.write(
      '${TsColors.blueLight}↓ RESPONSE ↓ [$requestNumber] ${clientIdMsg ?? ''}'
      '\n'
      '${TsColors.black}·\n',
    );

    final isSuccess = ApiLoggerConfig.instance.isStatusCodeSuccess(statusCode);
    buffer.write(
      '${isSuccess ? '✅ ${TsColors.green}Success' : '❌ ${TsColors.red}Failure'}'
      '${TsColors.grey} | Duration: ${TsColors.white}${DateTimeHelper.durationBetweenRequestAndResponse(requestStartTime: startTime, responseEndTime: endTime)}'
      '${TsColors.grey} | Body size: ${StringHelper.calculateBodySize(body)}'
      '\n',
    );

    buffer.write(
      '🔢 ${TsColors.white}Status code: ${statusCode == 200 ? TsColors.green : TsColors.red}$statusCode'
      '${statusCode == 0 ? '${TsColors.grey} | Device is most likely offline' : ''}'
      '\n',
    );

    if (body.isNotEmpty) {
      buffer.write(
          '📦 ${TsColors.white}Body: ${body.substringByLength(ApiLoggerConfig.instance.maxResponseLenghtForPrint).colorizeResponseBody()}');
    }

    return buffer.toString();
  }
}
