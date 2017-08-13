
abstract class CrossLanguageToFlutterDecoder {
  dynamic decode(dynamic encodedObject, Map<dynamic, String> objectTypeNames);

  Set<String> listSupportedTypeNames();
}
