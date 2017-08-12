import 'dart:async';

import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

abstract class SystemSettingsComponent {
  void setExecutionMode(ExecutionMode execution_mode);

  void setFlag(ID flag_name, bool flag_value);

  bool getFlag(ID flag_name);

  String getStringParameter(ID parameter_name, {String defaultValue});

  void setStringParameter(ID parameter_name, String parameter_value);

  void setSystemAssetID(ID parameter_name, ID parameter_value);

  ID getSystemAssetID(ID parameter_name);

  bool executionModeIsAtLeast(ExecutionMode mode);

  ExecutionMode getExecutionMode();

  void setIntParameter(ID parameterName, int parameterValue);

  int getIntParameter(ID parameterName);

  Map<ID, dynamic> listAllSettings();

  void clearAll();

  Future<bool> saveToStorage();
}
