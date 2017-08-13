import 'package:scarabei/api/cross-platform/cross_language_to_flutter_decoder.dart';
import 'package:scarabei/api/cross-platform/flutter_to_cross_language_encoder.dart';
import 'package:scarabei/api/cross-platform/scarabei_class_names.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

class CrossLanguageToScarabeiDecoder implements CrossLanguageToFlutterDecoder {
  Set<String> listSupportedTypeNames() {
    var result = new Set<String>();
    result.add(ScarabeiClassNames.ID_TYPE_STRING);
    result.add(ScarabeiClassNames.ExecutionMode_TYPE_STRING);
    return result;
  }

  CrossLanguageToScarabeiDecoder() {}

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
      return Names.newID(raw_id_string: encodedObject.toString());
    }

    if (objectTypeName == ScarabeiClassNames.ExecutionMode_TYPE_STRING) {
      return ExecutionMode.resolve(encodedObject.toString());
    }
    L.e("supported types", supported);
    Err.reportError("SupportedTypes list is corrupted <" + encodedObject + ">");
    return encodedObject;
  }
}
