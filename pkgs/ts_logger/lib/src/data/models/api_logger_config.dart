class ApiLoggerConfig {
  /// If the response body is longer than this value, it will be cut off.
  final int maxResponseLenghtForPrint;

  /// If true, null values in the response body will be printed additionally.
  final bool logBodyNullValues;

  /// Status codes that represent a successful response.
  final List<int> successStatusCodes;

  ApiLoggerConfig({
    this.maxResponseLenghtForPrint = 2000,
    this.logBodyNullValues = false,
    this.successStatusCodes = const [200, 201],
  });
}
