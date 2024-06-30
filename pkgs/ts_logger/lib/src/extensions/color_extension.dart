import 'dart:ui';

extension ColorExtension on Color {
  /// Converts the color to an ANSI color code.
  ///
  /// The ANSI color code is a string that can be used to colorize text in the terminal.
  String get toAnsi {
    return '\x1B[38;2;${red.toInt()};${green.toInt()};${blue.toInt()}m';
  }
}
