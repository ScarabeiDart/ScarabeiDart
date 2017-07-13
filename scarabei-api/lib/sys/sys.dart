library com.jfixby.scarabei.api.sys;

import 'package:scarabei_api/component_installer.dart';
import 'package:scarabei_api/sys/on_exit_listener.dart';
import 'package:scarabei_api/sys/system_component.dart';
import 'package:scarabei_api/sys/system_info.dart';
import 'package:scarabei_api/time/time_stream.dart';


class Sys {
  static ComponentInstaller<
      SystemComponent> _componentInstaller = new ComponentInstaller<
      SystemComponent>("Sys");

  static void installComponent(SystemComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }


  static SystemComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static SystemComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static SystemComponent component() {
    return _componentInstaller.getComponent();
  }

  static TimeStream SystemTime() {
    return invoke().SystemTime();
  }

  static TimeStream NoTime() {
    return invoke().NoTime();
  }

  static void exit() {
    invoke().exit();
  }


  static bool isWindows() {
    return invoke().isWindows();
  }

  static bool isUnix() {
    return invoke().isUnix();
  }

  static bool isMac() {
    return invoke().isMac();
  }

  static SystemInfo getSystemInfo() {
    return invoke().getSystemInfo();
  }


  static void addOnExitListener(OnExitListener listener) {
    invoke().addOnExitListener(listener);
  }

  static bool isIOS() {
    return invoke().isIOS();
  }

  static int currentTime() {
    return invoke().currentTime();
  }
}
