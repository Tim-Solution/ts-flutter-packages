enum LogLevel {
  /// Debug level 🐛
  debug,

  /// Info level 📄
  info,

  /// Warning level ⚠️
  warning,

  /// Error level ❌
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
      LogLevel.debug => '\x1B[38;2;192;202;51;m',
      LogLevel.info => '\x1B[0m',
      LogLevel.warning => '\x1B[33m',
      LogLevel.error => '\x1B[31m',
      LogLevel.verbose => '\x1B[38;2;66;165;245;m',
      LogLevel.critical => '\x1B[31m',
      LogLevel.fatal => '\x1B[31m',
    };
  }

  String get upperCaseName {
    return switch (this) {
      LogLevel.debug => 'DEBUG',
      LogLevel.info => 'INFO',
      LogLevel.warning => 'WARNING',
      LogLevel.error => 'ERROR',
      LogLevel.verbose => 'VERBOSE',
      LogLevel.critical => 'CRITICAL',
      LogLevel.fatal => 'FATAL',
    };
  }
}
