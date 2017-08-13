import 'dart:async';

import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings_component.dart';

class ScarabeiSystemSettingsFlutterProxy implements SystemSettingsComponent {
  Map<ID, dynamic> cache;

  ID callID;

  ScarabeiSystemSettingsFlutterProxy() {
    callID = Names.newID(raw_id_string: "com.jfixby.scarabei.red.flutter.plugins.android.sys.SystemSettingsWrapper");
  }

  @override
  void clearAll() {
    cache.clear();

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("clearAll");
    Future<Null> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  Future<bool> saveToStorage() async {
    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("saveToStorage");
    Future<bool> result = CrossPlatformCalls.makeCall(specs);
    return result;
  }

  @override
  void setStringParameter(ID parameter_name, String parameter_value) {
    cache[parameter_name] = parameter_value;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("setStringParameter");

    specs.addIDArgument(name: "$parameter_name", value: parameter_name);
    specs.addStringArgument(name: "$parameter_value", value: parameter_value);

    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  void setFlag(ID flag_name, bool flag_value) {
    cache[flag_name] = flag_value;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("setFlag");

    specs.addIDArgument(name: "$flag_name", value: flag_name);
    specs.addBoolArgument(name: "$flag_value", value: flag_value);

    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  void setExecutionMode(ExecutionMode execution_mode) {
    ID flag_name = ExecutionMode.ExecutionModeTAG();
    cache[flag_name] = execution_mode;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("setExecutionMode");
    specs.addExecutionModeArgument(name: "$execution_mode", value: execution_mode);
    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  void setIntParameter(ID parameterName, int parameterValue) {
    cache[parameterName] = parameterValue;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("setFlag");

    specs.addIDArgument(name: "$parameterName", value: parameterName);
    specs.addIntArgument(name: "$parameterValue", value: parameterValue);

    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  void setSystemAssetID(ID parameterName, ID parameterValue) {
    cache[parameterName] = parameterValue;

    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("setSystemAssetID");

    specs.addIDArgument(name: "$parameterName", value: parameterName);
    specs.addIDArgument(name: "$parameterValue", value: parameterValue);

    Future<bool> result = CrossPlatformCalls.makeCall(specs);
  }

  @override
  Map<ID, dynamic> listAllSettings() {
    Map<ID, dynamic> result = new Map<ID, dynamic>();
    result.addAll(cache);
    return result;
  }

  Future<ScarabeiSystemSettingsFlutterProxy> load() async {
    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("listAllSettings");
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
      return null;
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
