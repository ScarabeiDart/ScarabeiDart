library com.jfixby.scarabei.android.api;

import 'dart:async';

import 'package:scarabei/api/component_installer.dart';
import 'package:scarabei/api/cross-platform/cross_language_class_names.dart';
import 'package:scarabei/api/cross-platform/scarabei_class_names.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

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

  static dynamic decode(dynamic encodedObject, Map<dynamic, String> objectTypeNames) {
    return invoke().decode(encodedObject, objectTypeNames);
  }
}

abstract class CrossPlatformCallsComponent {
  CallSpecs newCallSpecs();

  Future<CallResult> makeCall(CallSpecs specs);

  dynamic decode(dynamic encodedObject, Map<dynamic, String> objectTypeNames);
}

class CallSpecs {
  ID callID;
  List<CallArgument> arguments = [];

  void addArgument({String name, dynamic value, String type}) {
    arguments.add(new CallArgument(name: name, value: value, type: type));
  }

  void addStringArgument({String name, String value}) =>
      addArgument(name: name, value: value, type: CrossLanguageClassNames.STRING);

  void addBoolArgument({String name, bool value}) =>
      addArgument(name: name, value: value, type: CrossLanguageClassNames.BOOL);

  void addIntArgument({String name, int value}) =>
      addArgument(name: name, value: value, type: CrossLanguageClassNames.INTEGER);

  void addListArgument({String name, List<dynamic> value}) =>
      addArgument(name: name, value: value, type: CrossLanguageClassNames.LIST);

  void addMapArgument({String name, Map<dynamic, dynamic> value}) =>
      addArgument(name: name, value: value, type: CrossLanguageClassNames.MAP);

  void addIDArgument({String name, ID value}) =>
      addArgument(name: name, value: value, type: ScarabeiClassNames.ID_TYPE_STRING);

  void addExecutionModeArgument({String name, ExecutionMode value}) =>
      addArgument(name: name, value: value, type: ScarabeiClassNames.ExecutionMode_TYPE_STRING);
}

class CallArgument {
  CallArgument({String name, dynamic value, String type}) {
    this.argumentName = name;
    this.argumentValue = value;
    this.argumentType = type;
  }

  String argumentName;
  dynamic argumentValue;
  String argumentType;
}

class CallResult {}
