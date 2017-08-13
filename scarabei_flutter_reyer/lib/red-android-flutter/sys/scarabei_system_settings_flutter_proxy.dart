import 'dart:async';

import 'package:flutter/services.dart';
import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings_component.dart';
import 'package:scarabei_flutter_reyer/red-android-flutter/sys/method_call_encoder.dart';

class ScarabeiSystemSettingsFlutterProxy implements SystemSettingsComponent {
  static const MethodChannel _channel =
      const MethodChannel("com.jfixby.scarabei.red.flutter.plugins.android.sys.SharedPreferencesPlugin");

  Map<ID, dynamic> cache;

  ID javaClassID;

  ScarabeiSystemSettingsFlutterProxy() {
    javaClassID =
        Names.newID(raw_id_string: "com.jfixby.scarabei.red.flutter.plugins.android.sys.SystemSettingsWrapper");
  }

  Future<dynamic> invoke(Map<String, dynamic> call) {
    L.d("invoke", Json.serializeToString(call));
    return _channel.invokeMethod('invoke', call);
  }

  @override
  void clearAll() {
    cache.clear();
    var call = MethodCallEncoder.encodeMethod(javaClassID, "clearAll", []);
    invoke(call);
  }

  @override
  Future<bool> saveToStorage() async {
    var call = MethodCallEncoder.encodeMethod(javaClassID,"saveToStorage", []);
    bool result = await invoke(call);
    return result;
  }

  @override
  void setStringParameter(ID parameter_name, String parameter_value) {
    cache[parameter_name] = parameter_value;

    var arguments = [];
    MethodCallEncoder.encodeID(arguments, name: "$parameter_name", value: parameter_name);
    MethodCallEncoder.encodeString(arguments, name: "$parameter_value", value: parameter_value);
    var call = MethodCallEncoder.encodeMethod(javaClassID,"setStringParameter", arguments);

    invoke(call);
  }

  @override
  void setFlag(ID flag_name, bool flag_value) {
    cache[flag_name] = flag_value;

    var arguments = [];
    MethodCallEncoder.encodeID(arguments, name: "$flag_name", value: flag_name);
    MethodCallEncoder.encodeBool(arguments, name: "$flag_value", value: flag_value);
    var call = MethodCallEncoder.encodeMethod(javaClassID,"setFlag", arguments);
    invoke(call);
  }

  @override
  void setExecutionMode(ExecutionMode execution_mode) {
    ID flag_name = ExecutionMode.ExecutionModeTAG();
    cache[flag_name] = execution_mode;

    var arguments = [];
    MethodCallEncoder.encodeID(arguments, name: "$flag_name", value: flag_name);
    MethodCallEncoder.encodeExecutionMode(arguments, name: "$execution_mode", value: execution_mode);
    var call = MethodCallEncoder.encodeMethod(javaClassID,"setExecutionMode", arguments);

    invoke(call);
  }

  @override
  void setIntParameter(ID parameterName, int parameterValue) {
    cache[parameterName] = parameterValue;

    var arguments = [];
    MethodCallEncoder.encodeID(arguments, name: "$parameterName", value: parameterName);
    MethodCallEncoder.encodeInt(arguments, name: "$parameterValue", value: parameterValue);
    var call = MethodCallEncoder.encodeMethod(javaClassID,"setIntParameter", arguments);

    invoke(call);
  }

  @override
  void setSystemAssetID(ID parameterName, ID parameterValue) {
    cache[parameterName] = parameterValue;

    var arguments = [];
    MethodCallEncoder.encodeID(arguments, name: "$parameterName", value: parameterName);
    MethodCallEncoder.encodeID(arguments, name: "$parameterValue", value: parameterValue);
    var call = MethodCallEncoder.encodeMethod(javaClassID,"setSystemAssetID", arguments);

    invoke(call);
  }

  @override
  Map<ID, dynamic> listAllSettings() {
    Map<ID, dynamic> result = new Map<ID, dynamic>();
    result.addAll(cache);
    return result;
  }

  Future<ScarabeiSystemSettingsFlutterProxy> load() async {
    var call = MethodCallEncoder.encodeMethod(javaClassID,"listAllSettings", []);
    cache = await invoke(call);
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
