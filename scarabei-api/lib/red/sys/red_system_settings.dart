library com.jfixby.scarabei.red.sys;

import 'package:scarabei_api/api/debug/debug.dart';
import 'package:scarabei_api/api/log/logger.dart';
import 'package:scarabei_api/api/names/names.dart';
import 'package:scarabei_api/api/sys/execution_mode.dart';
import 'package:scarabei_api/api/sys/settings/system_settings_component.dart';

class RedSystemSettings
    implements SystemSettingsComponent {
  ExecutionMode execution_mode = ExecutionMode.EARLY_DEVELOPMENT;
  Map<String, bool> flags = {};
  Map<String, int> longs = {};
  Map<String, String> strings = {};
  Map<String, ID> assets = {};

  void printSystemParameters() {
    L.d("---[SystemSettings]-----------------------------------");
    L.d("ExecutionMode", this.execution_mode);
    L.d("   Flags  ", flags);
    L.d("   ints   ", longs);
    L.d("   strings", strings);
    L.d("   assets ", assets);
    L.d("---[SystemSettings-END]-----------------------------------");
  }

  Map<String, String> listAllSettings() {
    Map<String, String> params = {};
    params["ExecutionMode"] = "" + this.execution_mode.toString();
    collect("flag", params, this.flags);
    collect("long", params, this.longs);
    collect("string", params, this.strings);
    collect("assets", params, this.assets);
    return params;
  }

  static

  void

  collect(String string, Map<String, String> params, Map<String, Object> input) {
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
      L.d("Flag not found", flag_name);
      return false;
    }
    return value;
  }

  String getStringParameter(String parameter_name) {
    String value = this.strings[parameter_name];
    if (value == null) {
      L.d("Parameter not found", parameter_name);
      return null;
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
      L.d("Parameter not found", parameter_name);
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

  void setLongParameter(String parameterName, int parameterValue) {
    this.longs[parameterName] = parameterValue;
  }

  int getLongParameter(String parameterName) {
    int value = this.longs[parameterName];
    if (value == null) {
      L.d("Parameter not found", parameterName);
      return 0;
    }
    return value;
  }
}
