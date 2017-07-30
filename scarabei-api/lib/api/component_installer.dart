import 'package:scarabei_api/api/error/err.dart';

class ComponentInstaller<T> {

  T _component;
  String _name;

  ComponentInstaller(String component_name) {
    this._name = component_name;
  }

  void installComponent(T component) {
    if (this._component != null) {
      Err.reportError(
          "Component " + this._name + " is already installed: $component");
    }
    this._component = component;
    if (this._component == null) {
      Err.reportError(
          "Component " + this._name + " is not installed. Argument is null.");
    }
  }

  T invokeComponent() {
    if (this._component == null) {
      Err.reportError("Component " + this._name + " is not installed.");
    }
    return this._component;
  }

  T getComponent() {
    return this._component;
  }

  T deInstallComponent() {
    if (this._component == null) {
      Err.reportError("Component " + this._name + " is not installed.");
    }
    T c = this._component;
    this._component = null;
    return c;
  }


}