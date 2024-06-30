// ignore_for_file: unnecessary_getters_setters

class ApiLoggerConfig {
  ApiLoggerConfig._();

  static ApiLoggerConfig? _instance;
  static ApiLoggerConfig get instance => _instance ??= ApiLoggerConfig._();

  int _maxResponseLenghtForPrint = 1500;
  int _messageSpacing = 2;
  bool _logRequestQueryParams = true;
  bool _logRequestBody = true;
  List<int> _successStatusCodes = [200, 201];

  int get maxResponseLenghtForPrint => _maxResponseLenghtForPrint;
  int get messageSpacing => _messageSpacing;
  bool get logRequestQueryParams => _logRequestQueryParams;
  bool get logRequestBody => _logRequestBody;
  List<int> get successStatusCodes => _successStatusCodes;

  bool isStatusCodeSuccess(int? statusCode) {
    if (statusCode == null) return false;
    return _successStatusCodes.contains(statusCode);
  }

  /// Represents the maximum length of the response body that will be printed in
  /// debug console.
  ///
  /// Note: Length must be greater than `0`. Default is `1500`.
  set maxResponseLenghtForPrint(int lenght) {
    assert(
      lenght >= 1,
      'maxResponseLenghtForPrint must be greater than 0.',
    );
    _maxResponseLenghtForPrint = lenght;
  }

  /// Message spacing means how many empty lines will be printed before and
  /// after the message.
  set messageSpacing(int spacing) => _messageSpacing = spacing;

  /// If `true`, query parameters will be printed in the request log.
  set logRequestQueryParams(bool value) => _logRequestQueryParams = value;

  /// If `true`, request body will be printed in the request log.
  set logRequestBody(bool value) => _logRequestBody = value;

  /// Represents the list of success status codes. Default is `[200, 201]`.
  /// Based on this list, the response will be represented as succes or failure.
  set successStatusCodes(List<int> codes) => _successStatusCodes = codes;
}
