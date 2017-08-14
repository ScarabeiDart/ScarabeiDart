import 'package:scarabei/api/codec/from_dart_encoder.dart';
import 'package:scarabei/api/cross-platform/class_names.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

class DartPrimitivesEncoder implements FromDartEncoder {
  bool canEncode(Object flutterObject) {
    if (flutterObject == null) {
      return true;
    }
    if (flutterObject is ExecutionMode) {
      return true;
    }
    if (flutterObject is ID) {
      return true;
    }
    if (flutterObject is String) {
      return true;
    }
    if (flutterObject is bool) {
      return true;
    }
    if (flutterObject is int) {
      return true;
    }
    if (flutterObject is Map) {
      return true;
    }
    if (flutterObject is Iterable) {
      return true;
    }

    return false;
  }

  Map<String, dynamic> encodeString(String value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.STRING);

  Map<String, dynamic> encodeBool(bool value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.BOOL);

  Map<String, dynamic> encodeInt(int value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.INTEGER);

  Map<String, dynamic> encodeIterable(Iterable<dynamic> value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.LIST);

  Map<String, dynamic> encodeMap(Map<dynamic, dynamic> value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.MAP);


  Map<String, dynamic> encode(Object flutterObject) {
    if (flutterObject == null) {
      return EncodedObject.encodeNull();
    }

    if (flutterObject is String) {
      return encodeString(flutterObject);
    }
    if (flutterObject is bool) {
      return encodeBool(flutterObject);
    }
    if (flutterObject is int) {
      return encodeInt(flutterObject);
    }
    if (encodeMap is Map) {
      return flutterObject;
    }
    if (flutterObject is Iterable) {
      return encodeIterable(flutterObject);
    }
    Err.reportError("Failed to encode <" + flutterObject + ">");
    return null;
  }
}
