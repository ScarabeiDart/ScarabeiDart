import 'package:scarabei_api/ComponentInstaller.dart';

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


  static void checkNull(Object obj, [String name]) {
    invoke().checkNull(obj, name);
  }

  static void checkTrue(Object obj, [String name]) {
    invoke().checkTrue(obj, name);
  }
}


abstract class DebugComponent {

  void checkNull(Object obj, [String name]);

  void checkTrue(bool value, [String name]);

}