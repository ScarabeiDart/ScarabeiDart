import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

abstract class SystemSettingsComponent {
  void setExecutionMode(ExecutionMode execution_mode);

  void setFlag(String flag_name, bool flag_value);

  bool getFlag(String flag_name);

  String getStringParameter(String parameter_name, {String defaultValue});

  void setStringParameter(String parameter_name, String parameter_value);

  void setSystemAssetID(String parameter_name, ID parameter_value);

  ID getSystemAssetID(String parameter_name);

  void printSystemParameters();

  bool executionModeIsAtLeast(ExecutionMode mode);

  ExecutionMode getExecutionMode();

  void setIntParameter(String parameterName, int parameterValue);

  int getIntParameter(String parameterName);

  Map<String, String> listAllSettings();

  ExecutionMode resolveExecutionMode(exeString);
}
