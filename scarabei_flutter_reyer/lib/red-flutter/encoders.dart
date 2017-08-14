import "package:scarabei/api/cross-platform/dart_to_cross_language_encoder.dart";
import 'package:scarabei/api/error/err.dart';

//package com.jfixby.scarabei.red.flutter.calls;

//import com.jfixby.scarabei.api.collections.Collections;
//import com.jfixby.scarabei.api.collections.List;
//import com.jfixby.scarabei.api.err.Err;
//import com.jfixby.scarabei.api.flutter.call.JavaToCrossLanguageEncoder;

class Encoders {
  List<DartToCrossLanguageEncoder> encoders = [];

  Map<String, dynamic> encode(Object flutterObject) {
    if (flutterObject == null) {
      return null;
    }
    for (DartToCrossLanguageEncoder e in this.encoders) {
      if (e.canEncode(flutterObject)) {
        return e.encode(flutterObject);
      }
    }
    Err.reportError("Encoder for <" + flutterObject + "> not found");
    return null;
  }

  void register(DartToCrossLanguageEncoder encoder) {
    this.encoders.add(encoder);
  }
}
