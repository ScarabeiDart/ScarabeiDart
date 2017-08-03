import 'package:scarabei/api/component_installer.dart';

class Err {
  static ComponentInstaller<ErrorComponent> _componentInstaller = new ComponentInstaller<ErrorComponent>("Error");

  static void installComponent(ErrorComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static ErrorComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static ErrorComponent invoke() {
    if (_componentInstaller.getComponent() == null) {
      throw new StateError("ErrorComponent is not installed");
    }
    return _componentInstaller.invokeComponent();
  }

  static ErrorComponent component() {
    return _componentInstaller.getComponent();
  }

  static void throwNotImplementedYet() {
    invoke().reportNotImplementedYet();
  }

  static void reportError(String message, [Error e]) {
    if (component() == null) {
      throw new StateError(message + " error: $e");
    }
    invoke().reportError(message, e);
  }
}

//reports errors to a local console or to a health-observer system
abstract class ErrorComponent {
  void reportError(String message, [Error e]);

  void reportNotImplementedYet();
}
