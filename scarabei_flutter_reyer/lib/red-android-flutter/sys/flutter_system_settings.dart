library com.jfixby.scarabei.red.sys;

import 'dart:async';

import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings_component.dart';
import 'package:scarabei_flutter_reyer/red-android-flutter/sys/scarabei_system_settings_flutter_proxy.dart';

class FlutterSystemSettings implements SystemSettingsComponent {
  final ScarabeiSystemSettingsFlutterProxy proxy = new ScarabeiSystemSettingsFlutterProxy();

  FlutterSystemSettings() {}

  Future<FlutterSystemSettings> load() async {
    await proxy.listAllSettings();
    return this;
  }

  @override
  bool executionModeIsAtLeast(ExecutionMode mode) {
    return proxy.executionModeIsAtLeast(mode);
  }

  @override
  ExecutionMode getExecutionMode() {
    return proxy.getExecutionMode();
  }

  @override
  bool getFlag(ID flag_name) {
    return proxy.getFlag(flag_name);
  }

  @override
  int getIntParameter(ID parameterName) {
    return proxy.getIntParameter(parameterName);
  }

  @override
  String getStringParameter(ID parameter_name, {String defaultValue = ""}) {
    return proxy.getStringParameter(parameter_name, defaultValue: defaultValue);
  }

  @override
  ID getSystemAssetID(ID parameter_name) {
    return proxy.getSystemAssetID(parameter_name);
  }

  @override
  Map<ID, dynamic> listAllSettings() {
    return proxy.listAllSettings();
  }

  @override
  void setExecutionMode(ExecutionMode execution_mode) {
    return proxy.setExecutionMode(execution_mode);
  }

  @override
  void setFlag(ID flag_name, bool flag_value) {
    return proxy.setFlag(flag_name, flag_value);
  }

  @override
  void setIntParameter(ID parameterName, int parameterValue) {
    return proxy.setIntParameter(parameterName, parameterValue);
  }

  @override
  void setStringParameter(ID parameter_name, String parameter_value) {
    return proxy.setStringParameter(parameter_name, parameter_value);
  }

  @override
  void setSystemAssetID(ID parameter_name, ID parameter_value) {
    return proxy.setSystemAssetID(parameter_name, parameter_value);
  }
}
