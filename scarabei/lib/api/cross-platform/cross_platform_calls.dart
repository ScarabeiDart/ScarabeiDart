import 'dart:async';

import 'package:scarabei/api/component_installer.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/names/names.dart';

class CrossPlatformCalls {
  static ComponentInstaller<CrossPlatformCallsComponent> _componentInstaller =
      new ComponentInstaller<CrossPlatformCallsComponent>("CrossPlatformCalls");

  static void installComponent(CrossPlatformCallsComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static CrossPlatformCallsComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static CrossPlatformCallsComponent component() {
    return _componentInstaller.getComponent();
  }

  static CallSpecs newCallSpecs() {
    return invoke().newCallSpecs();
  }

  static Future<dynamic> makeCall(CallSpecs specs) {
    return invoke().makeCall(specs);
  }
}

abstract class CrossPlatformCallsComponent {
  CallSpecs newCallSpecs();

  Future<CallResult> makeCall(CallSpecs specs);
}

class CallSpecs {
  ID callID;
  Map<String, dynamic> arguments = {};

  void addArgument({String name, dynamic value}) {
    Debug.checkNull(name, "name");
    Debug.checkEmpty(name, "name");
    arguments[name] = value;
  }
}

class CallResult {
  dynamic resultingObject;
  String errorMessage;
  bool success;
}
