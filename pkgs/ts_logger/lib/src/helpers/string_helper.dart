import 'dart:convert';

import 'package:ts_logger/src/constants/colors.dart';

abstract class StringHelper {
  StringHelper._();

  /// Calculate the size of the body in bytes and return it in KB or MB.
  static String calculateBodySize(String body) {
    List<int> bytes = utf8.encode(body);
    int sizeInBytes = bytes.length;
    double sizeInMB = sizeInBytes / (1024 * 1024);
    if (sizeInMB < 1) {
      return '${(sizeInBytes / 1024).toStringAsFixed(2)} KB';
    }
    return '${sizeInMB.toStringAsFixed(5)} MB';
  }

  static String colorizeApiMethod(String method) {
    method = method.toUpperCase();
    return switch (method) {
      'POST' => '${TsColors.methodPost}$method',
      'GET' => '${TsColors.methodGet}$method',
      'PUT' => '${TsColors.methodPut}$method',
      'DELETE' => '${TsColors.methodDelete}$method',
      'PATCH' => '${TsColors.methodPatch}$method',
      'HEAD' => '${TsColors.methodHead}$method',
      _ => '${TsColors.white}$method',
    };
  }
}
