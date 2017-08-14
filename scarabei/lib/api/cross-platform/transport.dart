import 'dart:async';

abstract class Transport {
  Future<dynamic> invokeMethod(String name, Map<String, dynamic> arguments);
}
