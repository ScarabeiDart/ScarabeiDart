import 'package:scarabei/api-flutter/flutter_app_version.dart';
import 'package:scarabei/api/component_installer.dart';
import 'package:scarabei/api/display/display_metrics.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/names/names.dart';

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

  static File getPrivateFolder() {
    return invoke().getPrivateFolder();
  }

  static File getCacheFolder() {
    return invoke().getCacheFolder();
  }

  static DisplayMetrics getDisplayMetrics() {
    return invoke().getDisplayMetrics();
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

  static FlutterAppVersion getAppVersion() {
    return invoke().getAppVersion();
  }

  static Map<ID, String> getSystemInfo() {
    return invoke().getSystemInfo();
  }
}

abstract class MobileDeviceComponent {
  int getMaxHeapSize();

  int getRecommendedHeapSize();

  String getApplicationPrivateDirPathString();

  File getPrivateFolder();

  File getCacheFolder();

  DisplayMetrics getDisplayMetrics();

  String getBrand();

  String getModel();

  String getHost();

  String getVersionRelease();

  FlutterAppVersion getAppVersion();

  Map<ID, String> getSystemInfo();

  String getSerial();

  String getFingerPrint();

  String getManufacturer();

  double densityIndependentPixels2Pixels(double dip);
}
