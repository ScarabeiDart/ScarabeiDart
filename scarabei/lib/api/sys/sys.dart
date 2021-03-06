import 'package:scarabei/api/component_installer.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/on_exit_listener.dart';
import 'package:scarabei/api/time/time_stream.dart';

class Sys {
  static ComponentInstaller<SystemComponent> _componentInstaller = new ComponentInstaller<SystemComponent>("Sys");

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

  static Map<ID, String> getSystemInfo() {
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

  static void sleep(int ms) => invoke().sleep(ms);
}

abstract class SystemComponent {
  TimeStream SystemTime();

  TimeStream NoTime();

  void exit();

  bool isWindows();

  bool isUnix();

  bool isMac();

  Map<ID, String> getSystemInfo();

  void addOnExitListener(OnExitListener listener);

  bool isIOS();

  int currentTime();

  sleep(int ms);
}
