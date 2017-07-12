library com.jfixby.scarabei.api.assets;

import 'package:scarabei_api/component_installer.dart';
import 'package:scarabei_api/names/id.dart';
import 'package:scarabei_api/names/names_component.dart';


class Names {
  static ComponentInstaller<
      NamesComponent> _componentInstaller = new ComponentInstaller<
      NamesComponent>("Names");

  static void installComponent(NamesComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }


  static NamesComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static NamesComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static NamesComponent component() {
    return _componentInstaller.getComponent();
  }


  static String SEPARATOR() {
    return invoke().SEPARATOR();
  }

  static ID ROOT() {
    return invoke().ROOT();
  }

  static ID newID({List<String> steps, String raw_id_string}) {
    return invoke().newID(steps: steps, raw_id_string: raw_id_string);
  }
}
