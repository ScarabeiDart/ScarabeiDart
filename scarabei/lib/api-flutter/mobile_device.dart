import 'package:scarabei/api/component_installer.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/mobile/mobile_app_version.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/scarabei.dart';

class MobileDevice {
  static ComponentInstaller<MobileDeviceComponent> _componentInstaller =
      new ComponentInstaller<MobileDeviceComponent>("MobileDevice");

  static void installComponent(MobileDeviceComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static MobileDeviceComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static MobileDeviceComponent component() {
    return _componentInstaller.getComponent();
  }

  static int getMaxHeapSize() {
    return invoke().getMaxHeapSize();
  }

  static int getRecommendedHeapSize() {
    return invoke().getRecommendedHeapSize();
  }

  static String getApplicationPrivateDirPathString() {
    return invoke().getApplicationPrivateDirPathString();
  }

  static LocalFile getPrivateFolder() {
    return invoke().getPrivateFolder();
  }

  static LocalFile getCacheFolder() {
    return invoke().getCacheFolder();
  }

  static String getBrand() {
    return invoke().getBrand();
  }

  static String getModel() {
    return invoke().getModel();
  }

  static String getHost() {
    return invoke().getHost();
  }

  static String getVersionRelease() {
    return invoke().getVersionRelease();
  }

  static MobileAppVersion getAppVersion() {
    return invoke().getAppVersion();
  }

  static Map<ID, dynamic> getSystemInfo() {
    return invoke().getSystemInfo();
  }
}

abstract class MobileDeviceComponent {
  int getMaxHeapSize();

  int getRecommendedHeapSize();

  String getApplicationPrivateDirPathString();

  LocalFile getPrivateFolder();

  LocalFile getCacheFolder();

  String getBrand();

  String getModel();

  String getHost();

  String getVersionRelease();

  MobileAppVersion getAppVersion();

  Map<ID, Object> getSystemInfo();

  String getSerial();

  String getFingerPrint();

  String getManufacturer();
}
