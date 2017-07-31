import 'dart:async';

import 'package:flutter/services.dart';
import 'package:scarabei/api-android/android.dart';
import 'package:scarabei/api-android/android_app_version.dart';
import 'package:scarabei/api/display/display_metrics.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/sys/system_info.dart';
import 'package:scarabei/red-android/sys/red_android_app_version.dart';
import 'package:scarabei/red/sys/red_system_info.dart';


//import com.jfixby.scarabei.android.api.AndroidAppVersion;
//import com.jfixby.scarabei.android.api.AndroidComponent;
//import com.jfixby.scarabei.android.api.AndroidSystemInfoTags;
//import com.jfixby.scarabei.api.display.DisplayMetrics;
//import com.jfixby.scarabei.api.err.Err;
//import com.jfixby.scarabei.api.file.File;
//import com.jfixby.scarabei.api.file.LocalFileSystem;
//import com.jfixby.scarabei.api.sys.SystemInfo;
//import com.jfixby.scarabei.api.sys.SystemInfoTags;
//import com.jfixby.scarabei.api.sys.settings.SystemSettings;
//import com.jfixby.scarabei.api.ver.Version;
//import com.jfixby.scarabei.red.sys.RedDeviceInfo;
//import android.app.ActivityManager;
//import android.app.Application;
//import android.content.Context;
//import android.content.pm.PackageInfo;
//import android.content.pm.PackageManager.NameNotFoundException;
//import android.os.Build;
//import android.util.TypedValue;
//import android.view.Display;
//import android.view.WindowManager;


class ScarabeiAndroidFlutterProxy implements AndroidComponent {
  static const MethodChannel _channel = const MethodChannel("com.jfixby.scarabei.red.flutter.plugins.android.ScarabeiAndroidFlutterProxy");

  Future<SystemInfo> getSystemInfo() async {
    Map<String, String> params = await _channel.invokeMethod('getSystemInfo');
    RedSystemInfo info = new RedSystemInfo();
    info.putAll(params);
    return info;
  }

  ScarabeiAndroidFlutterProxy() {


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
//    android.util.DisplayMetrics dm = new android.util.DisplayMetrics();
//    try {
//      WindowManager winman = (WindowManager)
//      this.context.getSystemService(Context.WINDOW_SERVICE);
//      Display display = winman.getDefaultDisplay();
//      display.getMetrics(dm);
//    }
//    catch
//    (
//    Exception
//    e
//    )
//    {
//    Err.reportError(e);
//    }
//    int
//    height
//    =
//    dm
//        .
//    heightPixels;
//    int
//    width
//    =
//    dm
//        .
//    widthPixels;
//
//    displayMetrics
//        .
//    set
//    (
//    width
//    ,
//    height
//    );
//
//    return
//    displayMetrics;
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


  AndroidAppVersion getAppVersion() {
    RedAndroidAppVersion version = new RedAndroidAppVersion();

//    try {
//      PackageInfo pInfo = this.app.getPackageManager().getPackageInfo(this.app.getPackageName(), 0);
//      version.package_name = this.app.getPackageName();
//      version.name = pInfo.versionName;
//      version.code = pInfo.versionCode;
//    }
//    catch
//    (
//    NameNotFoundException
//    e
//    )
//    {
//    e.printStackTrace();
//    }
//
//    return
//    version;
    Err.throwNotImplementedYet();
    return null;
  }


//  SystemInfo getSystemInfo() {
//    RedDeviceInfo deviceInfo = new RedDeviceInfo();
//    {
//      DisplayMetrics displayMetrics = this.getDisplayMetrics();
//      double height = displayMetrics.getHeight();
//      double width = displayMetrics.getWidth();
//      deviceInfo.putValue(AndroidSystemInfo.Display_WIDTH, width);
//      deviceInfo.putValue(AndroidSystemInfo.Display_HEIGHT, height);
//    }
//    {
//      String brand = this.getBrand();
//      deviceInfo.putValue(AndroidSystemInfo.Brand, brand);
//    }
//    {
//      String value = this.getSerial();
//      deviceInfo.putValue(AndroidSystemInfo.Serial, value);
//    }
//
//    {
//      String value = this.getFingerPrint();
//      deviceInfo.putValue(AndroidSystemInfo.Fingerprint, value);
//    }
//
//    {
//      String value = this.getManufacturer();
//      deviceInfo.putValue(AndroidSystemInfo.Manufacturer, value);
//    }
//
//    {
//      String model = this.getModel();
//      deviceInfo.putValue(AndroidSystemInfo.Model, model);
//    }
//    {
//      String release = this.getVersionRelease();
//      deviceInfo.putValue(AndroidSystemInfo.Release, release);
//    }
//
//    {
//      AndroidAppVersion version = this.getAppVersion();
//      deviceInfo.putValue(AndroidSystemInfo.App_Version_Name, version.getName());
//      deviceInfo.putValue(AndroidSystemInfo.App_Version_Code, version.getCode());
//      deviceInfo.putValue(AndroidSystemInfo.App_Version_PackageName, version.getPackageName());
//    }
//
//    {
//      String host = this.getHost();
//      deviceInfo.putValue(AndroidSystemInfo.Host, host);
//    }
//
//    {
////      deviceInfo.putValue(SystemInfoTags.System_OS_NAME, System.getProperty("os.name"));
////      deviceInfo.putValue(SystemInfoTags.System_OS_VERSION, System.getProperty("os.version"));
//      Err.throwNotImplementedYet();
//    }
//
//    {
//      deviceInfo.putValue(Version.AppPackageName, SystemSettings.getStringParameter(Version.AppPackageName));
//      deviceInfo.putValue(Version.AppVersionCode, SystemSettings.getStringParameter(Version.AppVersionCode));
//      deviceInfo.putValue(Version.AppVersionName, SystemSettings.getStringParameter(Version.AppVersionName));
//    }
//
//    return deviceInfo;
//  }
}
