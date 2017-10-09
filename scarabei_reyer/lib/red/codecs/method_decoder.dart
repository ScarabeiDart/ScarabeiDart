import 'package:scarabei/api/codec/codecs.dart';
import 'package:scarabei/api/codec/from_dart_encoder.dart';
import 'package:scarabei/api/codec/to_dart_decoder.dart';
import 'package:scarabei/api/cross-platform/class_names.dart';
import 'package:scarabei/api/cross-platform/method_result.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';

class MethodDecoder implements ToDartDecoder {
  Set<String> listSupportedTypeNames() {
    var result = new Set<String>();
    result.add(CrossLanguageClassNames.MethodCallResult);
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

    if (objectTypeName == CrossLanguageClassNames.MethodCallResult) {
      var emap = encodedObject as Map<dynamic, dynamic>;
      MethodResult result = new MethodResult();
      result.methodName = Codecs.decode(emap[MethodResult.RESULT_NAME]);
      result.success = Codecs.decode(emap[MethodResult.RESULT_SUCCESS_FLAG]);
      result.error = Codecs.decode(emap[MethodResult.RESULT_ERROR]);
      result.result = Codecs.decode(emap[MethodResult.RESULT_OBJECT]);

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
