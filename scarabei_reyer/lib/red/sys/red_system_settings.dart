library com.jfixby.scarabei.red.sys;

import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings_component.dart';

class RedSystemSettings implements SystemSettingsComponent {
  ExecutionMode execution_mode = ExecutionMode.EARLY_DEVELOPMENT;
  Map<String, bool> flags = {};
  Map<String, int> ints = {};
  Map<String, String> strings = {};
  Map<String, ID> assets = {};

  void printSystemParameters() {
    L.d("---[SystemSettings]-----------------------------------");
    L.d("ExecutionMode", this.execution_mode);
    L.d("     flags", flags);
    L.d("      ints", ints);
    L.d("   strings", strings);
    L.d("    assets", assets);
    L.d("---[SystemSettings-END]-----------------------------------");
  }

  Map<String, String> listAllSettings() {
    Map<String, String> params = {};
    params["ExecutionMode"] = "" + this.execution_mode.toString();
    collect("flag", params, this.flags);
    collect("long", params, this.ints);
    collect("string", params, this.strings);
    collect("assets", params, this.assets);
    return params;
  }

  static void collect(String string, Map<String, String> params, Map<String, Object> input) {
    for (String flagName in input.keys) {
      String key = ((string + ".") + flagName);
      String value = "" + input[flagName];
      params[key] = value;
    }
  }

  void setExecutionMode(ExecutionMode executionMode) {
    Debug.checkNull(executionMode, "ExecutionMode");
    this.execution_mode = executionMode;
  }

  void setFlag(String flag_name, bool flag_value) {
    this.flags[flag_name] = flag_value;
  }

  bool getFlag(String flag_name) {
    bool value = this.flags[flag_name];
    if (value == null) {
      L.e("Flag not found", flag_name);
      return false;
    }
    return value;
  }

  String getStringParameter(String parameter_name, {String defaultValue = ""}) {
    String value = this.strings[parameter_name];
    if (value == null) {
      L.e("Parameter not found", parameter_name);
      return defaultValue;
    }
    return value;
  }

  void setStringParameter(String parameter_name, String parameter_value) {
    this.strings[parameter_name] = parameter_value;
  }

  void setSystemAssetID(String parameter_name, ID parameter_value) {
    this.assets[parameter_name] = parameter_value;
  }

  ID getSystemAssetID(String parameter_name) {
    ID value = this.assets[parameter_name];
    if (value == null) {
      L.e("Parameter not found", parameter_name);
      return null;
    }
    return value;
  }

  bool executionModeIsAtLeast(ExecutionMode execution_mode) {
    return this.execution_mode.isAtLeast(execution_mode);
  }

  ExecutionMode getExecutionMode() {
    return this.execution_mode;
  }

  void setIntParameter(String parameterName, int parameterValue) {
    this.ints[parameterName] = parameterValue;
  }

  int getIntParameter(String parameterName) {
    int value = this.ints[parameterName];
    if (value == null) {
      L.e("Parameter not found", parameterName);
      return 0;
    }
    return value;
  }

  @override
  ExecutionMode resolveExecutionMode(exeString) {
    return ExecutionMode.resolve(exeString);
  }
}
