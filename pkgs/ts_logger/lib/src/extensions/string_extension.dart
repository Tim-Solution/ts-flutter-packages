// ignore_for_file: unnecessary_this

import 'package:ts_logger/src/constants/colors.dart';

extension StringExtension on String {
  /// Based on configuration, it will add empty lines before and after the message.
  String addRowSpacing(
    int spacing, {
    bool addLeading = true,
    bool addTrailing = true,
  }) {
    if (spacing > 0) {
      final leading = '${TsColors.black}·\n' * spacing;
      final trailing = '${TsColors.black}\n·' * spacing;
      return '${addLeading ? leading : ''}$this${addTrailing ? trailing : ''}';
    } else {
      return this;
    }
  }

  /// Colorize response body. Call this just on body string!
  String colorizeResponseBody() {
    return this
        .replaceAll('{', '${TsColors.aqua}{${TsColors.cyan}')
        .replaceAll('}', '${TsColors.aqua}}${TsColors.cyan}')
        .replaceAll(': ,', ': ${TsColors.pink}empty,')
        .replaceAll('null', '${TsColors.pink}null')
        .replaceAll(',', '${TsColors.aqua},${TsColors.cyan}');
  }

  /// Substring string by length. If string is longer than maxLenght, it will
  /// return substring of maxLenght. Otherwise, it will return original string.
  String substringByLength(int maxLenght) {
    if (this.length > maxLenght) {
      return '${this.substring(0, maxLenght)} ${TsColors.yellow}... + ${this.length - maxLenght} characters';
    }
    return this;
  }
}
