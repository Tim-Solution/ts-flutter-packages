import 'dart:convert';

import 'package:get/get_connect/http/src/request/request.dart' as g;

extension GetConnectRequestExtension on g.Request {
  Future<String> getBodyString() async {
    final bodyBytes = await this.bodyBytes.expand((chunk) => chunk).toList();
    return utf8.decode(bodyBytes).toString();
  }
}
