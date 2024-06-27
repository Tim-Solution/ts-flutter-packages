abstract class TsLoggerColors {
  TsLoggerColors._();

  static const black = '\x1B[30m';
  static const red = '\x1B[31m';
  static const green = '\x1B[38;2;30;215;96;m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const blueLight = '\x1B[38;2;0;141;253;m';
  static const aqua = '\x1B[38;2;183;220;214;m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';
  static const white = '\x1B[37m';
  static const accentGreen = '\x1B[92m';
  static const orange = '\x1B[38;2;251;192;45;m';
  static const pink = '\x1B[38;2;241;125;164;m';
  static const grey = '\x1B[38;2;128;128;128;m';

  static const methodGet = '\x1B[38;2;66;170;248;m'; // Blue
  static const methodPost = '\x1B[38;2;29;191;94;m'; // Green
  static const methodPut = '\x1B[38;2;255;161;0;m'; // Orange
  static const methodDelete = '\x1B[38;2;252;75;79;m'; // Red
  static const methodPatch = '\x1B[38;2;255;161;0;m'; // Orange
  static const methodHead = '\x1B[38;2;153;102;204;m'; // Purple

  static const statusCode200 = '\x1B[38;2;53;183;41;m'; // Green
  static const statusCode300 = '\x1B[38;2;82;113;255;m'; // Blue
  static const statusCode400 = '\x1B[38;2;255;92;92;m'; // Red
  static const statusCode500 = '\x1B[38;2;255;162;0;m'; // Orange
}
