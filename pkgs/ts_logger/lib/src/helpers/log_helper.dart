// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:ts_logger/src/extensions/string_extension.dart';

abstract class LogHelper {
  LogHelper._();

  static void logMessage(String message, {required int spacing}) {
    if (kIsWeb) {
      print(message.addRowSpacing(spacing));
    } else {
      log(
        message.addRowSpacing(spacing),
        name: 'TSL',
      );
    }
  }
}
