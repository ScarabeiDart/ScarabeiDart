import 'dart:async';

import 'package:scarabei/api-flutter/flutter_app_version.dart';
import 'package:scarabei/api-flutter/mobile_device.dart';
import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/display/display_metrics.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/names/names.dart';

class MobileDeviceFlutterProxy implements MobileDeviceComponent {
  Map<ID, String> _sysInfo;

  ID callID;

  SysSettingsFlutterProxy() {
    callID = Names.newID(string: "com.jfixby.scarabei.android.api.Android");
  }

  MobileDeviceFlutterProxy() {}

  Future<MobileDeviceFlutterProxy> load() async {
    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("getSystemInfo");
    _sysInfo = await CrossPlatformCalls.makeCall(specs);
    return this;
  }

  Map<ID, String> getSystemInfo() {
    var result = {};
    result.addAll(_sysInfo);
    return result;
  }

  double densityIndependentPixels2Pixels(double dip) {
//    return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, dip, this.context.getResources().getDisplayMetrics());
    Err.throwNotImplementedYet();
    return null;
  }

  int getRecommendedHeapSize() {
//    ActivityManager am = (ActivityManager)
//    this.app.getSystemService(Context.ACTIVITY_SERVICE);
//    int memoryClass = am.getMemoryClass();
//    return memoryClass;
    Err.throwNotImplementedYet();
    return null;
  }

  int getMaxHeapSize() {
//    Runtime rt = Runtime.getRuntime();
//    int maxMemory = rt.maxMemory() / (1024 * 1024);
//    // Log.v("onCreate", "maxMemory:" + Long.toString(maxMemory));
//    return maxMemory;
    Err.throwNotImplementedYet();
    return null;
  }

  String getApplicationPrivateDirPathString() {
//    String java_path = this.context.getFilesDir().getAbsolutePath();
//    return java_path;
    Err.throwNotImplementedYet();
    return null;
  }

  File getPrivateFolder() {
//    String path = this.getApplicationPrivateDirPathString();
//    File Folder = LocalFileSystem.newFile(path);
//    return Folder;
    Err.throwNotImplementedYet();
    return null;
  }

  File getCacheFolder() {
//    DartFile cache = this.app.getCacheDir();
//    return LocalFileSystem.newFile(cache);
    Err.throwNotImplementedYet();
    return null;
  }

  DisplayMetrics getDisplayMetrics() {
    DisplayMetrics displayMetrics = new DisplayMetrics();
    Err.throwNotImplementedYet();
    return null;
  }

  String getBrand() {
    Err.throwNotImplementedYet();
//    return Build.BRAND;
    return null;
  }

  String getSerial() {
    Err.throwNotImplementedYet();
//    return Build.SERIAL;
    return null;
  }

  String getModel() {
    Err.throwNotImplementedYet();
//    return Build.MODEL;
    return null;
  }

  String getFingerPrint() {
    Err.throwNotImplementedYet();
//    return Build.FINGERPRINT;
    return null;
  }

  String getManufacturer() {
    Err.throwNotImplementedYet();
//    return Build.MANUFACTURER;
    return null;
  }

  String getHost() {
    Err.throwNotImplementedYet();
//    return Build.HOST;
    return null;
  }

  String getVersionRelease() {
    Err.throwNotImplementedYet();
//    return Build.VERSION.RELEASE;
    return null;
  }

  FlutterAppVersion getAppVersion() {
    FlutterAppVersion version = new FlutterAppVersion();
    Err.throwNotImplementedYet();
    return null;
  }
}
