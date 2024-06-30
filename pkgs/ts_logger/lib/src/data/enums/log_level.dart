import 'dart:ui';

import 'package:ts_logger/src/extensions/color_extension.dart';

enum LogLevel {
  /// Debug level 🐛
  debug,

  /// Info level 📄
  info,

  /// Warning level ⚠️
  warning,

  /// Error level ⛔️
  error,

  /// Verbose level 🔍
  verbose,

  /// Critical level 🚨
  critical,

  /// Fatal level 💀
  fatal,
}

extension LogLevelExtension on LogLevel {
  String get emoji {
    return switch (this) {
      LogLevel.debug => '🐛',
      LogLevel.info => '📄',
      LogLevel.warning => '⚠️',
      LogLevel.error => '⛔️',
      LogLevel.verbose => '🔍',
      LogLevel.critical => '🚨',
      LogLevel.fatal => '💀',
    };
  }

  String get ansiColor {
    return switch (this) {
      LogLevel.debug => const Color.fromARGB(255, 222, 231, 86).toAnsi,
      LogLevel.info => const Color.fromARGB(255, 124, 204, 247).toAnsi,
      LogLevel.warning => const Color.fromARGB(255, 245, 178, 71).toAnsi,
      LogLevel.error => const Color.fromARGB(255, 252, 92, 92).toAnsi,
      LogLevel.verbose => const Color.fromARGB(255, 42, 137, 214).toAnsi,
      LogLevel.critical => const Color.fromARGB(255, 255, 72, 69).toAnsi,
      LogLevel.fatal => const Color.fromARGB(255, 255, 15, 15).toAnsi,
    };
  }

  String get readableName {
    return switch (this) {
      LogLevel.debug => 'Debug',
      LogLevel.info => 'Info',
      LogLevel.warning => 'Warning',
      LogLevel.error => 'Error',
      LogLevel.verbose => 'Verbose',
      LogLevel.critical => 'Critical',
      LogLevel.fatal => 'Fatal',
    };
  }
}
