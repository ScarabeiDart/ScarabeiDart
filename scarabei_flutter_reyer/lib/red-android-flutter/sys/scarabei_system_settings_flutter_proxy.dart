import 'dart:async';

import 'package:flutter/services.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings_component.dart';

class ScarabeiSystemSettingsFlutterProxy implements SystemSettingsComponent {
  static const MethodChannel _channel =
      const MethodChannel("com.jfixby.scarabei.red.flutter.plugins.android.sys.SharedPreferencesPlugin");

  Map<String, Object> cache;

  ScarabeiSystemSettingsFlutterProxy() {}

  Future<ScarabeiSystemSettingsFlutterProxy> load() async {
    cache = await _channel.invokeMethod('getAll');
    return this;
  }

  @override
  String getStringParameter(String parameter_name, {String defaultValue = ""}) {
    if (cache.containsKey(parameter_name)) {
      return cache[parameter_name];
    } else {
      return defaultValue;
    }
  }

  void _setValue(String valueType, String key, Object value) {
    cache[key] = value;
    // Set the value in the background.
    _channel.invokeMethod('set$valueType', <String, dynamic>{
      'key': '$key',
      'value': value,
    });
  }

  @override
  void setStringParameter(String parameter_name, String parameter_value) {
    cache[parameter_name] = parameter_value;
    _setValue('String', parameter_name, parameter_value);
  }

  @override
  void setFlag(String flag_name, bool flag_value) {
    // TODO: implement setFlag
  }

  @override
  void setIntParameter(String parameterName, int parameterValue) {
    // TODO: implement setIntParameter
  }

  @override
  void setSystemAssetID(String parameter_name, ID parameter_value) {
    // TODO: implement setSystemAssetID
  }


  @override
  bool executionModeIsAtLeast(ExecutionMode mode) {
    // TODO: implement executionModeIsAtLeast
  }

  @override
  ExecutionMode getExecutionMode() {
    // TODO: implement getExecutionMode
  }

  @override
  bool getFlag(String flag_name) {
    // TODO: implement getFlag
  }

  @override
  int getIntParameter(String parameterName) {
    // TODO: implement getIntParameter
  }

  @override
  ID getSystemAssetID(String parameter_name) {
    // TODO: implement getSystemAssetID
  }

  @override
  Map<String, String> listAllSettings() {
    // TODO: implement listAllSettings
  }

  @override
  ExecutionMode resolveExecutionMode(exeString) {
    // TODO: implement resolveExecutionMode
  }

  @override
  void setExecutionMode(ExecutionMode execution_mode) {
    // TODO: implement setExecutionMode
  }


}
