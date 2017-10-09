import 'package:scarabei/api/component_installer.dart';
import 'package:scarabei/api/md5/md5_string.dart';

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


  static MD5String md5String({String md5String}) {
    return invoke().md5String(md5String: md5String);
  }

  static MD5String hashString({String stringToHash}) {
    return invoke().hashString(stringToHash: stringToHash);
  }

  static MD5String hashBytes({List<int> bytes}) {
    return invoke().hashBytes(bytes: bytes);
  }
}

abstract class MD5Component {

  MD5String md5String({String md5String});

  MD5String hashString({String stringToHash});

  MD5String hashBytes({List<int> bytes});

}
