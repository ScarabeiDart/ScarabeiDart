library com.jfixby.scarabei.api.sys.settings;

import 'package:scarabei_api/api/component_installer.dart';
import 'package:scarabei_api/api/names/names.dart';
import 'package:scarabei_api/api/sys/execution_mode.dart';
import 'package:scarabei_api/api/sys/settings/system_settings_component.dart';


class SystemSettings {
  static ComponentInstaller<
      SystemSettingsComponent> _componentInstaller = new ComponentInstaller<
      SystemSettingsComponent>("SystemSettings");

  static void installComponent(SystemSettingsComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }


  static SystemSettingsComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static SystemSettingsComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static SystemSettingsComponent component() {
    return _componentInstaller.getComponent();
  }

  static void setFlag(String flag_name, bool flag_value) {
    invoke().setFlag(flag_name, flag_value);
  }

  static bool getFlag(String flag_name) {
    return invoke().getFlag(flag_name);
  }

  static String getStringParameter(String parameter_name) {
    return invoke().getStringParameter(parameter_name);
  }

  static void setLongParameter(String parameterName, int parameterValue) {
    invoke().setLongParameter(parameterName, parameterValue);
  }

  static void setStringParameter(String parameter_name, String parameter_value) {
    invoke().setStringParameter(parameter_name, parameter_value);
  }

  static void setSystemAssetID(String parameter_name, ID parameter_value) {
    invoke().setSystemAssetID(parameter_name, parameter_value);
  }

  static ID getSystemAssetID(String parameter_name) {
    return invoke().getSystemAssetID(parameter_name);
  }

  static void printSystemParameters() {
    invoke().printSystemParameters();
  }

  static bool executionModeIsAtLeast(ExecutionMode mode) {
    return invoke().executionModeIsAtLeast(mode);
  }

  static ExecutionMode getExecutionMode() {
    return invoke().getExecutionMode();
  }

  static int getLongParameter(String parameterName) {
    return invoke().getLongParameter(parameterName);
  }

  static Map<String, String> listAllSettings() {
    return invoke().listAllSettings();
  }

  static void setExecutionMode(ExecutionMode mode) {
    invoke().setExecutionMode(mode);
  }
}
