library com.jfixby.scarabei.red.sys;

import 'dart:async';

import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings_component.dart';
import 'package:scarabei_flutter_reyer/red-android-flutter/sys/shared_preferences_flutter_plugin.dart';

class FlutterSystemSettings implements SystemSettingsComponent {
  SharedPreferences prefs;

  FlutterSystemSettings() {}

  Future<FlutterSystemSettings> load() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  Map<String, String> listAllSettings() {
    Map<String, String> params = {};
    Map<String, Object> all = prefs.getAll();
    for (String key in all.keys) {
      params[key] = all[key].toString();
    }
    return params;
  }

  static void collect(String string, Map<String, String> params, Map<String, Object> input) {
    for (String flagName in input.keys) {
      String key = ((string + ".") + flagName);
      String value = "" + input[flagName];
      params[key] = value;
    }
  }

  void setFlag(String flag_name, bool flag_value) {
    prefs.setBool(flag_name, flag_value);
  }

  bool getFlag(String flag_name) {
    bool value = prefs.getBool(flag_name);
    if (value == null) {
      L.e("Flag not found", flag_name);
      return false;
    }
    return value;
  }

  String getStringParameter(String parameter_name, {String defaultValue = ""}) {
    String value = prefs.getString(parameter_name);
    if (value == null) {
      L.e("Parameter<$parameter_name> not found, returning default value: <$defaultValue>");
      return defaultValue;
    }
    return value;
  }

  void setStringParameter(String parameter_name, String parameter_value) {
    this.setStringParameter(parameter_name, parameter_value);
  }

  void setSystemAssetID(String parameter_name, ID parameter_value) {
    this.setStringParameter(parameter_name, parameter_value.toString());
  }

  ID getSystemAssetID(String parameter_name) {
    String value = prefs.getString(parameter_name);
    if (value == null) {
      L.e("Parameter not found", parameter_name);
      return null;
    }
    if (!Names.isValidString(value)) {
      L.e("Parameter<$parameter_name> is invalid", value);
    }
    return Names.newID(raw_id_string: value);
  }

  bool executionModeIsAtLeast(ExecutionMode execution_mode) {
    return this.getExecutionMode().isAtLeast(execution_mode);
  }

  ExecutionMode getExecutionMode() {
    return ExecutionMode.resolve(prefs.getString(ExecutionMode.TAG));
  }

  void setExecutionMode(ExecutionMode executionMode) {
    Debug.checkNull(executionMode, "ExecutionMode");
    prefs.setString(ExecutionMode.TAG, executionMode.toString());
  }

  void setIntParameter(String parameterName, int parameterValue) {
    prefs.setInt(parameterName, parameterValue);
  }

  int getIntParameter(String parameterName) {
    return prefs.getInt(parameterName);
  }

  @override
  ExecutionMode resolveExecutionMode(exeString) {
    return ExecutionMode.resolve(exeString);
  }
}
