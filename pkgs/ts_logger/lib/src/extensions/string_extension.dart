// ignore_for_file: unnecessary_this

import 'package:ts_logger/src/constants/colors.dart';

extension StringExtension on String {
  /// Based on configuration, it will add empty lines before and after the message.
  String addRowSpacing(int spacing) {
    if (spacing > 0) {
      final leading = '${TsColors.black}·\n' * spacing;
      final trailing = '${TsColors.black}\n·' * spacing;
      return '$leading$this$trailing';
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
}
