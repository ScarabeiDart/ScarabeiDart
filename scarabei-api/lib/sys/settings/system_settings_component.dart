import 'package:scarabei_api/names/id.dart';
import 'package:scarabei_api/sys/execution_mode.dart';


abstract class SystemSettingsComponent {

  void setExecutionMode(ExecutionMode execution_mode);

  void setFlag(String flag_name, bool flag_value);

  bool getFlag(String flag_name);

  String getStringParameter(String parameter_name);

  void setStringParameter(String parameter_name, String parameter_value);

  void setSystemAssetID(String parameter_name, ID parameter_value);

  ID getSystemAssetID(String parameter_name);

  void printSystemParameters();

  bool executionModeIsAtLeast(ExecutionMode mode);

  ExecutionMode getExecutionMode();

  void setLongParameter(String parameterName, int parameterValue);

  int getLongParameter(String parameterName);

  Map<String, String> listAllSettings();
}

