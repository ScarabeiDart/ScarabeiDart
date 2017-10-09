import "package:scarabei/api/codec/from_dart_encoder.dart";
import 'package:scarabei/api/error/err.dart';

//package com.jfixby.scarabei.red.flutter.calls;

//import com.jfixby.scarabei.api.collections.Collections;
//import com.jfixby.scarabei.api.collections.List;
//import com.jfixby.scarabei.api.err.Err;
//import com.jfixby.scarabei.api.flutter.call.JavaToCrossLanguageEncoder;

class Encoders {
  List<FromDartEncoder> encoders = [];

  Map<String, dynamic> encode(Object flutterObject) {

    for (FromDartEncoder e in this.encoders) {
      if (e.canEncode(flutterObject)) {
        return e.encode(flutterObject);
      }
    }
    Err.reportError("Encoder for <" + flutterObject.toString() + "> not found");
    return null;
  }

  void register(FromDartEncoder encoder) {
    this.encoders.add(encoder);
  }
}
