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
      LogLevel.info => '\x1B[38;2;156;220;254;m',
      LogLevel.warning => '\x1B[38;2;255;176;46;m',
      LogLevel.error => '\x1B[38;2;247;86;85;m',
      LogLevel.verbose => '\x1B[38;2;66;165;245;m',
      LogLevel.critical => '\x1B[38;2;248;49;47;m',
      LogLevel.fatal => '\x1B[38;2;255;0;255;m',
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
