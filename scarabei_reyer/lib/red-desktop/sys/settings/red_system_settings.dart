import 'dart:async';

import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings_component.dart';

class RedSystemSettings implements SystemSettingsComponent {
  ExecutionMode execution_mode = ExecutionMode.EARLY_DEVELOPMENT;

  final Map<ID, dynamic> storage = {};

  @override
  Map<ID, dynamic> listAllSettings() {
    Map<ID, dynamic> result = new Map<ID, dynamic>();
    result.addAll(storage);
    return result;
  }

  @override
  void setExecutionMode(final ExecutionMode executionMode) {
    Debug.checkNull(executionMode, "ExecutionMode");
    this.execution_mode = executionMode;
  }

  void setFlag(final ID flag_name, final bool flag_value) {
    this.storage[flag_name] = flag_value;
  }

  bool getFlag(final ID flag_name) {
    final bool value = this.storage[flag_name];
    if (value == null) {
      L.d("Flag not found", flag_name);
      return false;
    }
    return value;
  }

  String getStringParameter(final ID parameter_name, {String defaultValue}) {
    final String value = this.storage[parameter_name];
    if (value == null) {
      return defaultValue;
    }
    return value;
  }

  void setStringParameter(final ID parameter_name, final String parameter_value) {
    this.storage[parameter_name] = parameter_value;
  }

  void setSystemAssetID(final ID parameter_name, final ID parameter_value) {
    this.storage[parameter_name] = parameter_value;
  }

  ID getSystemAssetID(final ID parameter_name) {
    final ID value = this.storage[parameter_name];
    if (value == null) {
      L.d("Parameter not found", parameter_name);
      return null;
    }
    return value;
  }

  bool executionModeIsAtLeast(final ExecutionMode execution_mode) {
    return this.execution_mode.isAtLeast(execution_mode);
  }

  ExecutionMode getExecutionMode() {
    return this.execution_mode;
  }

  void setIntParameter(final ID parameterName, final int parameterValue) {
    storage[parameterName] = parameterValue;
  }

  int getIntParameter(final ID parameterName) {
    final int value = this.storage[parameterName];
    if (value == null) {
      L.d("Parameter not found", parameterName);
      return 0;
    }
    return value;
  }

  void clearAll() {
    this.storage.clear();
  }

  @override
  Future<bool> saveToStorage() async {
    // TODO: implement saveToStorage
    L.e("RedSystemSettings.saveToStorage() is not implemented yet!");
//    Err.throwNotImplementedYet();
    return false;
  }

  @override
  Future<SystemSettingsComponent> reloadFromStorage() async {
    // TODO: implement reloadFromStorage
    L.e("RedSystemSettings.reloadFromStorage() is not implemented yet!");
    return this;
  }
}
