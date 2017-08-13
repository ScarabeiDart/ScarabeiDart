//package com.jfixby.scarabei.api.flutter.call;

abstract class FlutterToCrossLanguageEncoder {
  bool canEncode(Object javaObject);

  Object encode(Object javaObject);
}
