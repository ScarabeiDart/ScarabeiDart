library com.jfixby.scarabei.android.api;

import 'package:scarabei_android_api/android_app_version.dart';
import 'package:scarabei_android_api/android_system_info.dart';
import 'package:scarabei_api/component_installer.dart';
import 'package:scarabei_api/display/display_metrics.dart';
import 'package:scarabei_api/sys/system_info.dart';
import 'package:scarabei_api/files/file.dart';

class Android {
  static ComponentInstaller<AndroidComponent> _componentInstaller = new ComponentInstaller<AndroidComponent>("Android");

  static void installComponent(AndroidComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static AndroidComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static AndroidComponent component() {
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

  static AndroidAppVersion getAppVersion() {
    return invoke().getAppVersion();
  }

  static SystemInfo getSystemInfo() {
    return invoke().getSystemInfo();
  }
}

abstract class AndroidComponent {

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

  AndroidAppVersion getAppVersion();

  SystemInfo getSystemInfo();

  String getSerial();

  String getFingerPrint();

  String getManufacturer();

  double densityIndependentPixels2Pixels(double dip);
}

