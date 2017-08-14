//package com.jfixby.scarabei.api.flutter.call;

import 'package:scarabei/api/cross-platform/cross_language_class_names.dart';

abstract class DartToCrossLanguageEncoder {
  bool canEncode(Object flutterObject);

  Map<String, dynamic> encode(Object flutterObject);
}

class EncodedObject {
  static const String VALUE = "value";
  static const String TYPE = "type";

  static Map<String, dynamic> encodeNull() => encodeObject(value: null, type: CrossLanguageClassNames.NULL);

  static Map<String, dynamic> encodeObject({dynamic value, String type}) => {VALUE: value, TYPE: type};
}
