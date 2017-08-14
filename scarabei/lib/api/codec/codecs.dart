import 'package:scarabei/api/codec/from_dart_encoder.dart';
import 'package:scarabei/api/codec/to_dart_decoder.dart';
import 'package:scarabei/api/component_installer.dart';

class Codecs {
  static ComponentInstaller<CodecsComponent> _componentInstaller = new ComponentInstaller<CodecsComponent>("Codecs");

  static void installComponent(CodecsComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static CodecsComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static CodecsComponent component() {
    return _componentInstaller.getComponent();
  }

  static dynamic decode(Map<String, dynamic> encoded) {
    return invoke().decode(encoded);
  }

  static Map<String, dynamic> encode(Object dartObject) {
    return invoke().encode(dartObject);
  }

  static void registerDecoder(ToDartDecoder decoder) {
    invoke().registerDecoder(decoder);
  }

  static void registerEncoder(FromDartEncoder encoder) {
    invoke().registerEncoder(encoder);
  }
}

abstract class CodecsComponent {
  dynamic decode(Map<String, dynamic> encoded);

  Map<String, dynamic> encode(Object dartObject);

  void registerDecoder(ToDartDecoder decoder);

  void registerEncoder(FromDartEncoder encoder);
}
