// ignore_for_file: unnecessary_getters_setters

class ApiLoggerConfig {
  ApiLoggerConfig._();

  static ApiLoggerConfig? _instance;
  static ApiLoggerConfig get instance => _instance ??= ApiLoggerConfig._();

  int _maxResponseBodyLengthForPrint = 1500;
  int _messageSpacing = 2;
  bool _logRequestQueryParams = true;
  bool _logRequestHeaders = false;
  bool _logRequestBody = true;
  bool _logRequestStartTime = true;
  List<String> _ignoreRequestHeaders = ['Authorization'];
  List<int> _successStatusCodes = [200, 201];
  Duration? _reportInterval = const Duration(minutes: 10);

  int get maxResponseBodyLengthForPrint => _maxResponseBodyLengthForPrint;
  int get messageSpacing => _messageSpacing;
  bool get logRequestQueryParams => _logRequestQueryParams;
  bool get logRequestHeaders => _logRequestHeaders;
  bool get logRequestBody => _logRequestBody;
  bool get logRequestStartTime => _logRequestStartTime;
  List<String> get ignoreRequestHeaders => _ignoreRequestHeaders;
  List<int> get successStatusCodes => _successStatusCodes;
  Duration? get reportInterval => _reportInterval;

  List<String> get ignoreRequestHeadersLowerCase {
    return ignoreRequestHeaders.map((e) => e.toLowerCase()).toList();
  }

  bool isStatusCodeSuccess(int? statusCode) {
    if (statusCode == null) return false;
    return _successStatusCodes.contains(statusCode);
  }

  /// Represents the maximum length of the response body that will be printed in
  /// debug console.
  ///
  /// Note: Length must be greater than `0`. Default is `1500`.
  set maxResponseBodyLengthForPrint(int lenght) {
    assert(
      lenght >= 1,
      'maxResponseLenghtForPrint must be greater than 0.',
    );
    _maxResponseBodyLengthForPrint = lenght;
  }

  /// Message spacing means how many empty lines will be printed before and
  /// after the message.
  set messageSpacing(int spacing) => _messageSpacing = spacing;

  /// If `true`, query parameters will be printed in the request log.
  set logRequestQueryParams(bool value) => _logRequestQueryParams = value;

  /// If `true`, request headers will be printed in the request log.
  set logRequestHeaders(bool value) => _logRequestHeaders = value;

  /// If `true`, request body will be printed in the request log.
  set logRequestBody(bool value) => _logRequestBody = value;

  /// If `true`, request start time will be printed in the request log.
  set logRequestStartTime(bool value) => _logRequestStartTime = value;

  /// Represents the list of headers that will be ignored in the request log.
  set ignoreRequestHeaders(List<String> headers) => _ignoreRequestHeaders = headers;

  /// Represents the list of success status codes. Default is `[200, 201]`.
  /// Based on this list, the response will be represented as succes or failure.
  set successStatusCodes(List<int> codes) => _successStatusCodes = codes;

  /// Represents the interval for reporting the number of successful and failed
  /// requests. `null` means disable.
  ///
  /// Reports will be printed periodically in the debug console for given
  /// interval.
  ///
  /// **Note**: If you change this after activating logger for any client,
  /// you need to restart the app to apply changes.
  ///
  /// Default is `Duration(minutes: 10)`.
  set reportInterval(Duration? duration) => _reportInterval = duration;
}
