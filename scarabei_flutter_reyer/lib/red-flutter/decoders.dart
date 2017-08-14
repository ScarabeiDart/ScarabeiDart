import "package:scarabei/api/cross-platform/cross_language_to_dart_decoder.dart";
import 'package:scarabei/api/cross-platform/dart_to_cross_language_encoder.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';

class Decoders {
  Map<String, CrossLanguageToDartDecoder> decoders = {};

  dynamic decode(Map<String, dynamic> encoded) {
    Debug.checkNull(encoded, "encoded");

    String objectTypeName = encoded[EncodedObject.TYPE];
    Object encodedObject = encoded[EncodedObject.VALUE];

    if (encodedObject == null) {
      return null;
    }

    if (objectTypeName == null) {
      Err.reportError("Missing object type for <" + encodedObject + ">");
      return null;
    }

    CrossLanguageToDartDecoder decoder = this.decoders[objectTypeName];
    if (decoder == null) {
      Err.reportError("Decoder not found <" + objectTypeName + "> " + encodedObject);
      return null;
    }

    Object result = decoder.decode(encoded);
    return result;
  }

  void registerDecoder(CrossLanguageToDartDecoder flutterToScarabeiDecoder) {
    Set<String> list = flutterToScarabeiDecoder.listSupportedTypeNames();
    for (String name in list) {
      CrossLanguageToDartDecoder prev = this.decoders[name];
      if (prev != null) {
        L.e("Replacing CrossLanguageToFlutterDecoder on type <" + name + ">");
        L.e("          removing", prev);
        L.e("        registring", flutterToScarabeiDecoder);
      }

      this.decoders[name] = flutterToScarabeiDecoder;
      L.d("Registered CrossLanguageToFlutterDecoder[" + name + "]", flutterToScarabeiDecoder);
    }
  }
}
