import 'dart:convert';

abstract class StringHelper {
  StringHelper._();

  /// Calculate the size of the body in bytes and return it in KB or MB.
  String calculateBodySize(String body) {
    List<int> bytes = utf8.encode(body);
    int sizeInBytes = bytes.length;
    double sizeInMB = sizeInBytes / (1024 * 1024);
    if (sizeInMB < 1) {
      return '[ ${(sizeInBytes / 1024).toStringAsFixed(2)} KB ]';
    }
    return '[ ${sizeInMB.toStringAsFixed(5)} MB ]';
  }
}
