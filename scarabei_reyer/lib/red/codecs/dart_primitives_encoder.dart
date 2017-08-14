import 'package:scarabei/api/codec/codecs.dart';
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

    if (flutterObject is ID) {
      return true;
    }
    if (flutterObject is String) {
      return true;
    }
    if (flutterObject is bool) {
      return true;
    }
    if (flutterObject is double) {
      return true;
    }
    if (flutterObject is int) {
      return true;
    }
//    if (flutterObject is Map) {
//      return true;
//    }
    if (flutterObject is Iterable) {
      return true;
    }
    if (flutterObject is ExecutionMode) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> encodeString(String value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.STRING);

  Map<String, dynamic> encodeBool(bool value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.BOOL);

  Map<String, dynamic> encodeInt(int value) =>
      EncodedObject.encodeObject(value: value.toString(), type: CrossLanguageClassNames.INTEGER);

  Map<String, dynamic> encodeDecimal(double value) =>
      EncodedObject.encodeObject(value: value.toString(), type: CrossLanguageClassNames.INTEGER);

  Map<String, dynamic> encodeIterable(Iterable<dynamic> value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.LIST);

//  Map<String, dynamic> encodeMap(Map<dynamic, dynamic> value) =>
//      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.MAP);

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
    if (flutterObject is double) {
      return encodeDecimal(flutterObject);
    }
    if (flutterObject is int) {
      return encodeInt(flutterObject);
    }
//    if (flutterObject is Map) {
//      Map<String, dynamic> content = {};
//      List<Map<String, dynamic>> ePairs = [];
//      for (dynamic key in flutterObject.keys) {
//        dynamic val = flutterObject[key];
//        Map<String, dynamic> eK = Codecs.encode(key);
//        eKeys.add(eK);
//        Map<String, dynamic> eV = Codecs.encode(val);
//        content[eK] = eV;
//      }
//      return flutterObject;
//    }
    if (flutterObject is Iterable) {
      List<Map<String, dynamic>> eList = [];
      for (dynamic e in flutterObject) {
        eList.add(Codecs.encode(e));
      }
      return encodeIterable(eList);
    }
    Err.reportError("Failed to encode <" + flutterObject + ">");
    return null;
  }
}
