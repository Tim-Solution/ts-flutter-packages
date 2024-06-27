import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:ts_logger/src/extensions/string_extension.dart';

abstract class LogHelper {
  LogHelper._();

  static void logMessage(String message) {
    if (kDebugMode) {
      if (kIsWeb) {
        print(message);
      } else {
        log(
          message.addRowSpacing(),
          name: 'TSL',
        );
      }
    }
  }
}
