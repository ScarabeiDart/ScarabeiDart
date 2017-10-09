import 'package:scarabei/api/codec/to_dart_decoder.dart';
import 'package:scarabei/api/codec/from_dart_encoder.dart';
import 'package:scarabei/api/codec/scarabei_class_names.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

class ScarabeiDecoder implements ToDartDecoder {
  Set<String> listSupportedTypeNames() {
    var result = new Set<String>();
    result.add(ScarabeiClassNames.ID_TYPE_STRING);
    result.add(ScarabeiClassNames.ExecutionMode_TYPE_STRING);
    return result;
  }

  ScarabeiDecoder() {}

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

    if (objectTypeName == ScarabeiClassNames.ID_TYPE_STRING) {
      return Names.newID(string: encodedObject.toString());
    }

    if (objectTypeName == ScarabeiClassNames.ExecutionMode_TYPE_STRING) {
      return ExecutionMode.resolve(encodedObject.toString());
    }
    L.e("supported types", supported);
    Err.reportError("SupportedTypes list is corrupted <" + encodedObject + ">");
    return encodedObject;
  }
}
