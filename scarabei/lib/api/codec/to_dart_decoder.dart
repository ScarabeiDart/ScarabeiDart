abstract class ToDartDecoder {
  dynamic decode(Map<String, dynamic> encodedObject);

  Set<String> listSupportedTypeNames();
}
