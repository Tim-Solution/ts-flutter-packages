![ts_logger_cover](https://github.com/Tim-Solution/ts-flutter-packages/assets/89051381/ab646b68-f6d9-466f-acde-cd09a75f7d3b)

Designed to enable the user to debug their code and api requests as easily as possible. The package is made so that it is completely safe to use in any environment.( All features will work
only if `kDebugMode == true` )


## Features
- Log api client requests and responses.
- Log colorized messages to the console.
- Log messages to the console with different log levels.
- Log FlutterError to the console with level and stack trace.


## Configuration
- You can configure many things with this package. Please check below example for more details.

### Configuration setup
```dart
TsLogger.instance.configure((
  messageLoggerConfig,
  apiLoggerConfig,
) {
    // MessageLoggerConfig
    messageLoggerConfig.example = 'example';
    // ApiLoggerConfig
    apiLoggerConfig.example = 'example';

    // Please check properties motioned below for more details.
});
```

### MessageLoggerConfig properties
| Property | Description | Default |
| --- | --- | --- |
| `logLevels` | Only the levels you specify using this property will be displayed in the debug console. Useful in the case when, for example, you are only interested in fatal errors etc.. | `LogLevel.values` (All) |
| `messageSpacing` | The spacing around the message in the console. | `0` |
| `colorizeLogs` | If true, the messages will be colorized, otherwise text will be white. | `true` |
| `logMessageTime` | If true, the time when the message was logged will be displayed. | `true` |

### ApiLoggerConfig properties

| Property | Description | Default |
| --- | --- | --- |
| `maxResponseLenghtForPrint` | The maximum length of the body which will be printed to the console. | `1500` |
| `messageSpacing` | The spacing around the message in the console. | `2` |
| `logRequestQueryParams` | If true, the query parameters will be displayed in the console. | `true` |
| `logRequestBody` | If true, the request body will be displayed in the console. | `true` |
| `successStatusCodes` | The status codes which will be considered as successful. | `[200, 201]` |
| `reportInterval` | Represents the interval for reporting the number of successful and failed requests. `null` means disable. | `Duration(minutes: 10)` |


## Usage | Api logging

### Api request and response logging
- Log api client requests and responses. * This is just basic example of usage.
```dart
import 'package:get/get.dart' as g;
import 'package:dio/dio.dart' as d;

final getConnectClient = g.GetConnect();
TsLogger.instance.activateGetConnectLogger(getConnectClient.httpClient);
getConnectClient.get('https://jsonplaceholder.typicode.com/users');

final dioClient = d.Dio();
TsLogger.instance.activateDioLogger(dioClient);
dioClient.get('https://jsonplaceholder.typicode.com/users');

// Requests and responses will be logged to the console.
```



## Usage | Message logging

### Log messages
- Log messages to the console with different log levels. Every log will be unique displayed based on the log level.
```dart
TsLogger.instance.logColorizedMessage(...); // Log message with any color
TsLogger.instance.logMessage(...); // Log message for provided log level
TsLogger.instance.logDebug(...); // Log message with debug log level
TsLogger.instance.logInfo(...); // Log message with info log level
TsLogger.instance.logWarning(...); // Log message with warning log level
TsLogger.instance.logError(...); // Log message with error log level
TsLogger.instance.logFatal(...); // Log message with fatal log level
TsLogger.instance.logVerbose(...); // Log message with verbose log level
TsLogger.instance.logCritical(...); // Log message with critical log level
```

### FlutterError logging
- Log FlutterError to the console with level and stack trace.
```dart
FlutterError.onError = (FlutterErrorDetails details) {
  TsLogger.instance.onFlutterError(details);
};
```

## Examples
### Message logging example
![image](https://github.com/Tim-Solution/ts-flutter-packages/assets/89051381/89fa34d7-99c3-4160-904f-5460a74880e1)

### Api logging example
![image](https://github.com/Tim-Solution/ts-flutter-packages/assets/89051381/f931eff8-06ab-45a3-8789-77cc0017d948)


## ToDo
### Support for packages
- [x] Add logging support for [get_connect](https://pub.dev/packages/get#getconnect) package
- [x] Add logging support for [dio](https://pub.dev/packages/dio) package
- [ ] Add logging support for [http](https://pub.dev/packages/http) package
