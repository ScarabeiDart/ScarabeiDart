import 'package:scarabei_api/component_installer.dart';
import 'package:scarabei_api/io/input_stream.dart';
import 'package:scarabei_api/md5/md5_string.dart';

class MD5 {
  static ComponentInstaller<
      MD5Component> _componentInstaller = new ComponentInstaller<
      MD5Component>("MD5");


  static void installComponent(MD5Component component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static MD5Component deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static MD5Component invoke() {
    return _componentInstaller.invokeComponent();
  }

  static MD5Component component() {
    return _componentInstaller.getComponent();
  }

  static MD5String md5Stream(InputStream java_input_stream) {
    return invoke().md5Stream(java_input_stream);
  }

  static MD5String md5String(String password) {
    return invoke().md5String(password);
  }
}

abstract class MD5Component {

  MD5String md5String(String password);

  MD5String md5Stream(InputStream input_stream);
}
