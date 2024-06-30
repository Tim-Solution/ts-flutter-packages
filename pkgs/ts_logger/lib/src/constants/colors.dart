import 'dart:ui';

import 'package:ts_logger/src/extensions/color_extension.dart';

abstract class TsColors {
  TsColors._();

  static final black = const Color.fromRGBO(0, 0, 0, 1).toAnsi;
  static final red = const Color.fromRGBO(255, 0, 0, 1).toAnsi;
  static final green = const Color.fromRGBO(30, 215, 96, 1).toAnsi;
  static final yellow = const Color.fromRGBO(255, 255, 0, 1).toAnsi;
  static final blue = const Color.fromRGBO(0, 0, 255, 1).toAnsi;
  static final blueLight = const Color.fromRGBO(0, 141, 253, 1).toAnsi;
  static final aqua = const Color.fromRGBO(183, 220, 214, 1).toAnsi;
  static final magenta = const Color.fromRGBO(255, 0, 255, 1).toAnsi;
  static final cyan = const Color.fromRGBO(0, 255, 255, 1).toAnsi;
  static final white = const Color.fromRGBO(255, 255, 255, 1).toAnsi;
  static final accentGreen = const Color.fromRGBO(0, 255, 0, 1).toAnsi;
  static final orange = const Color.fromRGBO(251, 192, 45, 1).toAnsi;
  static final pink = const Color.fromRGBO(241, 125, 164, 1).toAnsi;
  static final grey = const Color.fromRGBO(128, 128, 128, 1).toAnsi;

  static final methodGet = const Color.fromRGBO(66, 170, 248, 1).toAnsi;
  static final methodPost = const Color.fromRGBO(29, 191, 94, 1).toAnsi;
  static final methodPut = const Color.fromRGBO(255, 161, 0, 1).toAnsi;
  static final methodDelete = const Color.fromRGBO(252, 75, 79, 1).toAnsi;
  static final methodPatch = const Color.fromRGBO(255, 161, 0, 1).toAnsi;
  static final methodHead = const Color.fromRGBO(153, 102, 204, 1).toAnsi;

  static final statusCode200 = const Color.fromRGBO(53, 183, 41, 1).toAnsi;
  static final statusCode300 = const Color.fromRGBO(82, 113, 255, 1).toAnsi;
  static final statusCode400 = const Color.fromRGBO(255, 92, 92, 1).toAnsi;
  static final statusCode500 = const Color.fromRGBO(255, 162, 0, 1).toAnsi;
}
