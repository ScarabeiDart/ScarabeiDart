import 'package:scarabei_api/collections/sequence.dart';
import 'package:scarabei_api/component_installer.dart';
import 'package:scarabei_api/utils/byte_array.dart';

class Strings {

  static ComponentInstaller<
      StringsComponent> _componentInstaller = new ComponentInstaller<
      StringsComponent>("Strings");

  static void installComponent(StringsComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }


  static StringsComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static StringsComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static StringsComponent component() {
    return _componentInstaller.getComponent();
  }

  static String newString({List<int> bytes, ByteArray byteArray, String encoding}) {
    return invoke().newString(bytes: bytes, byteArray: byteArray, encoding: encoding);
  }


  static String replaceAll(String input, Map<String, String> termsMapping) {
    return invoke().replaceAll(input, termsMapping);
  }


  static String wrapSequence(Sequence<String> seq, int size, String bracketLeft, String bracketRight, String separator) {
    return invoke().wrapSequence(seq, size, bracketLeft, bracketRight, separator);
  }


}


abstract class StringsComponent {

  String newString({List<int> bytes, ByteArray byteArray, String encoding});

  String replaceAll(String input, Map<String, String> termsMapping);

  String wrapSequence(Sequence<String> seq, int size, String bracketLeft, String bracketRight, String separator);
}