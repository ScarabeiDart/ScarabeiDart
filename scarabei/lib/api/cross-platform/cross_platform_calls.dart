import 'dart:async';

import 'package:scarabei/api/component_installer.dart';
import 'package:scarabei/api/cross-platform/method_argument.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
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
  List<MethodArgument> arguments = [];

  void addArgument(String name, dynamic value) {
    Debug.checkNull(name, "name");
    Debug.checkEmpty(name, "name");
    if (value == null) {
      Err.reportError("Null argument is not welcome here <" + name + ">");
    }
    MethodArgument arg = new MethodArgument();
    arg.argumentName = name;
    arg.argumentValue = value;
    if (arguments.contains(arg)) {
      Err.reportError("Duplicate name <" + name + ">");
    }
    arguments.add(arg);
  }
}

class CallResult {
  dynamic resultingObject;
  String errorMessage;
  bool success;
}
