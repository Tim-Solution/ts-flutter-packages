## TS Logger
Ts Logger is a package designed to enable the user to debug their code and api requests as easily as possible. More below. The package is made so that it is completely safe to use in any environment. ( It will work only when `kDebugMode == true` )

## Features
- Log messages to the console with different log levels.
- Log colorized messages to the console.
- Log FlutterError to the console with level and stack trace.
- Log api client requests and responses.


## Usage | Message logging
### FlutterError logging
- Log FlutterError to the console with level and stack trace.
```dart
FlutterError.onError = (FlutterErrorDetails details) {
  TsLogger.instance.onFlutterError(details);
};
```

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

## Usage | Api request & response logging
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




## ToDo
### Support for packages
- [x] Add logging support for [get_connect](https://pub.dev/packages/get#getconnect) package
- [x] Add logging support for [dio](https://pub.dev/packages/dio) package
- [ ] Add logging support for [http](https://pub.dev/packages/http) package
