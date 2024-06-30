// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:ts_logger/src/extensions/string_extension.dart';

abstract class LogHelper {
  LogHelper._();

  static void logMessage(String message) {
    if (kIsWeb) {
      print(message.addRowSpacing());
    } else {
      log(
        message.addRowSpacing(),
        name: 'TSL',
      );
    }
  }
}
