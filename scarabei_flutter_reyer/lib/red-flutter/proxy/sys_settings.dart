import 'dart:async';

import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings_component.dart';

class SysSettingsFlutterProxy implements SystemSettingsComponent {
  Map<ID, dynamic> cache;

  ID methodID;

  SysSettingsFlutterProxy() {
    methodID = Names.newID(string: "com.jfixby.scarabei.api.sys.settings.SystemSettings");
  }

  @override
  void clearAll() {
    cache.clear();

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = methodID.child("clearAll");
    Future<Null> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  Future<bool> saveToStorage() async {
    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = methodID.child("saveToStorage");
    Future<bool> result = CrossPlatformCalls.makeCall(specs);
    return result;
  }

  @override
  void setStringParameter(ID parameter_name, String parameter_value) {
    cache[parameter_name] = parameter_value;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = methodID.child("setStringParameter");

    specs.addArgument("parameter_name", parameter_name);
    specs.addArgument("parameter_value", parameter_value);

    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  void setFlag(ID flag_name, bool flag_value) {
    cache[flag_name] = flag_value;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = methodID.child("setFlag");

    specs.addArgument("flag_name", flag_name);
    specs.addArgument("flag_value", flag_value);

    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  void setExecutionMode(ExecutionMode execution_mode) {
    ID flag_name = ExecutionMode.ExecutionModeTAG();
    cache[flag_name] = execution_mode;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = methodID.child("setExecutionMode");
    specs.addArgument("execution_mode", execution_mode);
    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  void setIntParameter(ID parameterName, int parameterValue) {
    cache[parameterName] = parameterValue;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = methodID.child("setIntParameter");

    specs.addArgument("parameterName", parameterName);
    specs.addArgument("parameterValue", parameterValue);

    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  void setSystemAssetID(ID parameterName, ID parameterValue) {
    cache[parameterName] = parameterValue;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = methodID.child("setSystemAssetID");

    specs.addArgument("parameterName", parameterName);
    specs.addArgument("parameterValue", parameterValue);

    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  Map<ID, dynamic> listAllSettings() {
    Map<ID, dynamic> result = new Map<ID, dynamic>();
    result.addAll(cache);
    return result;
  }

  Future<SysSettingsFlutterProxy> reloadFromStorage() async {
    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = methodID.child("listAllSettings");
    Future<Map<ID, dynamic>> result = CrossPlatformCalls.makeCall(specs);
    cache = await result;
    return this;
  }

  @override
  bool executionModeIsAtLeast(ExecutionMode mode) {
    return getExecutionMode().isAtLeast(mode);
  }

  @override
  ExecutionMode getExecutionMode() {
    if (cache.containsKey(ExecutionMode.ExecutionModeTAG())) {
      return cache[ExecutionMode.ExecutionModeTAG()];
    } else {
      return ExecutionMode.defaultMode;
    }
  }

  @override
  bool getFlag(ID flag_name) {
    if (cache.containsKey(flag_name)) {
      return cache[flag_name];
    } else {
      return false;
    }
  }

  @override
  int getIntParameter(ID parameterName) {
    if (cache.containsKey(parameterName)) {
      return cache[parameterName];
    } else {
      return null;
    }
  }

  @override
  ID getSystemAssetID(ID parameter_name) {
    if (cache.containsKey(parameter_name)) {
      return cache[parameter_name];
    } else {
      return null;
    }
  }

  @override
  String getStringParameter(ID parameter_name, {String defaultValue = ""}) {
    if (cache.containsKey(parameter_name)) {
      return cache[parameter_name];
    } else {
      return defaultValue;
    }
  }
}
