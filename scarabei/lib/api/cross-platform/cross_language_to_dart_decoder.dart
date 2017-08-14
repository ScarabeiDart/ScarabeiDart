import 'package:scarabei/api/cross-platform/dart_to_cross_language_encoder.dart';


abstract class CrossLanguageToDartDecoder {
  dynamic decode(Map<String, dynamic> encodedObject);

  Set<String> listSupportedTypeNames();
}
