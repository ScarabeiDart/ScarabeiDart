import 'dart:async';

import 'package:scarabei/api/cross-platform/transport.dart';
import 'package:scarabei/api/log/logger.dart';

class StubTransport implements Transport {
  @override
  Future<dynamic> invokeMethod(String name, Map<String, dynamic> arguments) {
    L.d("invokeMethod[$name]", arguments);
    return null;
  }
}
