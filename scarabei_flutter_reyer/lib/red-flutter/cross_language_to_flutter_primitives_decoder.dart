import 'package:scarabei/api/cross-platform/cross_language_class_names.dart';
import 'package:scarabei/api/cross-platform/cross_language_to_flutter_decoder.dart';
import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/cross-platform/scarabei_class_names.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

class CrossLanguageToFlutterPrimitivesDecoder implements CrossLanguageToFlutterDecoder {
  Set<String> listSupportedTypeNames() {
    var result = new Set<String>;
    result.add(CrossLanguageClassNames.STRING);
    result.add(CrossLanguageClassNames.BOOL);
    result.add(CrossLanguageClassNames.INTEGER);
    result.add(CrossLanguageClassNames.LIST);
    result.add(CrossLanguageClassNames.MAP);

    return result;
  }

  CrossLanguageToFlutterPrimitivesDecoder() {}

  dynamic decode(dynamic encodedObject, Map<dynamic, String> objectTypeNames) {
    if (encodedObject == null) {
      return null;
    }

    String objectTypeName = objectTypeNames[encodedObject];
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
      List list = encodedObject as List<dynamic>;

      List<dynamic> result = new List<dynamic>();
      for (dynamic Ei in list) {
        dynamic Ri = CrossPlatformCalls.decode(Ei, objectTypeNames);
        result.add(Ri);
      }
      return result;
    }

    if (objectTypeName == CrossLanguageClassNames.MAP) {
      Map map = encodedObject as Map<dynamic, dynamic>;
      Map<dynamic, dynamic> result = {};
      for (Object Ki in map.keys) {
        dynamic Vi = map[Ki];

        dynamic RKi = CrossPlatformCalls.decode(Ki, objectTypeNames);
        dynamic RVi = CrossPlatformCalls.decode(Vi, objectTypeNames);

        result[RKi] = RVi;
      }
      return result;
    }

    if (objectTypeName == CrossLanguageClassNames.STRING) {
      return encodedObject as String;
    }

    if (objectTypeName == CrossLanguageClassNames.INTEGER) {
      return encodedObject as int;
    }

    if (objectTypeName == CrossLanguageClassNames.BOOL) {
      return encodedObject as bool;
    }

    L.e("supported types", supported);
    Err.reportError("SupportedTypes list is corrupted <" + encodedObject + ">");
    return encodedObject;
  }
}
