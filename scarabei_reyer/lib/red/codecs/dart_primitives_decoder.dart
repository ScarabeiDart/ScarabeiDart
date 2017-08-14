import 'package:scarabei/api/codec/codecs.dart';
import 'package:scarabei/api/codec/from_dart_encoder.dart';
import 'package:scarabei/api/codec/to_dart_decoder.dart';
import 'package:scarabei/api/cross-platform/class_names.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';

class DartPrimitivesDecoder implements ToDartDecoder {
  Set<String> listSupportedTypeNames() {
    var result = new Set<String>();
    result.add(CrossLanguageClassNames.STRING);
    result.add(CrossLanguageClassNames.BOOL);
    result.add(CrossLanguageClassNames.INTEGER);
    result.add(CrossLanguageClassNames.LIST);
    result.add(CrossLanguageClassNames.MAP);
    result.add(CrossLanguageClassNames.Exception);
    result.add(CrossLanguageClassNames.DOUBLE);
    result.add(CrossLanguageClassNames.NULL);

    return result;
  }

  DartPrimitivesDecoder() {}

  dynamic decode(Map<String, dynamic> encoded) {
    Debug.checkNull(encoded, "encoded");

    String objectTypeName = encoded[EncodedObject.TYPE];
    Object encodedObject = encoded[EncodedObject.VALUE];

    if (encodedObject == null) {
      return null;
    }
    var supported = listSupportedTypeNames();
    if (!supported.contains(objectTypeName)) {
      L.e("supported types", supported);
      Err.reportError("Unsupported object type<" + objectTypeName + "> for " + objectTypeName);
      return null;
    }

    if (objectTypeName == null) {
      Err.reportError("Missing object type for <" + encodedObject + ">");
      return null;
    }

    if (objectTypeName == CrossLanguageClassNames.LIST) {
      List<Map<String, dynamic>> list = encodedObject as List<Map<String, dynamic>>;

      List<dynamic> result = new List<dynamic>();
      for (Map<String, dynamic> Ei in list) {
        dynamic Ri = Codecs.decode(Ei);
        result.add(Ri);
      }
      return result;
    }

    if (objectTypeName == CrossLanguageClassNames.MAP) {
      List<List<Map<dynamic, dynamic>>> emap = encodedObject as List<List<Map<dynamic, dynamic>>>;
      Map<dynamic, dynamic> result = new Map<dynamic, dynamic>();
      for (var pair in emap) {
        Map<dynamic, dynamic> eKey = pair[0];
        Map<dynamic, dynamic> eVal = pair[1];
        dynamic key = Codecs.decode(eKey);
        dynamic val = Codecs.decode(eVal);
        if (result.containsKey(key)) {
          Err.reportError("Duplicate key", key);
        }
        result[key] = val;
      }
      return result;
    }

    if (objectTypeName == CrossLanguageClassNames.STRING) {
      return encodedObject as String;
    }

    if (objectTypeName == CrossLanguageClassNames.INTEGER) {
      return encodedObject as int;
    }

    if (objectTypeName == CrossLanguageClassNames.DOUBLE) {
      return encodedObject as double;
    }

    if (objectTypeName == CrossLanguageClassNames.BOOL) {
      return encodedObject as bool;
    }
    if (objectTypeName == CrossLanguageClassNames.NULL) {
      return null;
    }
    if (objectTypeName == CrossLanguageClassNames.Exception) {
      return new Exception(encodedObject as String);
    }

    L.e("supported types", supported);
    Err.reportError("SupportedTypes list is corrupted <" + encodedObject + ">");
    return encodedObject;
  }
}
