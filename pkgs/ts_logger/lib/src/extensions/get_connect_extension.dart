import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:get/get_connect/http/src/request/request.dart' as g;

extension GetConnectRequestExtension on g.Request {
  Future<String> getBodyString() async {
    try {
      final bodyBytes = await this.bodyBytes.expand((chunk) => chunk).toList();
      return utf8.decode(bodyBytes).toString();
    } catch (e) {
      debugPrint('Error in getBodyString: $e');
      return 'Error while reading body. Most likely this is a multi-part request or something else that is not supported by this extension.';
    }
  }
}
