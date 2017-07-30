import 'package:scarabei_api/api/component_installer.dart';
import 'package:scarabei_api/api/debug/state_switcher.dart';

class Debug {

  static ComponentInstaller<
      DebugComponent> _componentInstaller = new ComponentInstaller<
      DebugComponent>("Debug");

  static void installComponent(DebugComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }


  static DebugComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static DebugComponent invoke() {
    if (_componentInstaller.getComponent() == null) {
      throw new StateError("DebugComponent is not installed");
    }
    return _componentInstaller.invokeComponent();
  }

  static DebugComponent component() {
    return _componentInstaller.getComponent();
  }


  static T checkNull<T>(T obj, [String name]) {
    return invoke().checkNull(obj, name);
  }

  static void checkEmpty(String string, [String name]) {
    invoke().checkEmpty(string, name);
  }


  static void checkTrue(Object obj, [String name]) {
    invoke().checkTrue(obj, name);
  }

  static StateSwitcher<T> newStateSwitcher<T>(T default_state) {
    return invoke().newStateSwitcher(default_state);
  }
}


abstract class DebugComponent {

  T checkNull<T>(T obj, [String name]);

  void checkTrue(bool value, [String name]);

  String checkEmpty(String string, [String name]);

  StateSwitcher<T> newStateSwitcher<T>(T default_state);

}