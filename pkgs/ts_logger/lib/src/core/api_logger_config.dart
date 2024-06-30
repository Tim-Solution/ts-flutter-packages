// ignore_for_file: unnecessary_getters_setters

class ApiLoggerConfig {
  ApiLoggerConfig._();

  static ApiLoggerConfig? _instance;
  static ApiLoggerConfig get instance => _instance ??= ApiLoggerConfig._();

  int _maxResponseLenghtForPrint = 2000;
  int _messageSpacing = 0;
  bool _logRequestNumber = true;

  int get maxResponseLenghtForPrint => _maxResponseLenghtForPrint;
  int get messageSpacing => _messageSpacing;
  bool get logRequestNumber => _logRequestNumber;

  /// Represents the maximum length of the response body that will be printed in
  /// debug console.
  ///
  /// Note: Length must be greater than `0`. Default is `2000`.
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

  /// If [log] is true, the request number will be printed with the message.
  /// Default is `true`.
  set logRequestNumber(bool log) => _logRequestNumber = log;
}
