import 'dart:async';

import 'package:scarabei/api-flutter/mobile_device.dart';
import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/mobile/mobile_app_version.dart';
import 'package:scarabei/api/mobile/system_info_tags.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/ver/version.dart';

class MobileDeviceFlutterProxy implements MobileDeviceComponent {
  Map<ID, dynamic> _sysInfo;

  ID callID;

  MobileDeviceFlutterProxy() {
    callID = Names.newID(string: "com.jfixby.scarabei.api.mobile.MobileDevice");
  }

  Future<MobileDeviceFlutterProxy> load() async {
    var specs = CrossPlatformCalls.newCallSpecs();
    specs.callID = callID.child("getSystemInfo");
    _sysInfo = await CrossPlatformCalls.makeCall(specs);
    L.d("MobileDeviceFlutterProxy", _sysInfo);
    return this;
  }

  Map<ID, dynamic> getSystemInfo() {
    var result = {};
    result.addAll(_sysInfo);
    return result;
  }

  MobileAppVersion getAppVersion() {
    MobileAppVersion version = new MobileAppVersion();

    version.packageName = _sysInfo[MobileSystemInfoTags.App_Version_PackageName];
    version.code = _sysInfo[MobileSystemInfoTags.App_Version_Code];
    version.name = _sysInfo[MobileSystemInfoTags.App_Version_Name];

    return version;
  }

  int getRecommendedHeapSize() {
    return _sysInfo[Version.AppVersionName];
  }

  int getMaxHeapSize() {
    return _sysInfo[MobileSystemInfoTags.App_Version_Name];
  }

  @override
  String getApplicationPrivateDirPathString() {
    Err.throwNotImplementedYet();
    return null;
  }

  @override
  String getBrand() => _sysInfo[MobileSystemInfoTags.Brand];

  @override
  File getCacheFolder() {
    Err.throwNotImplementedYet();
    return null;
  }

  @override
  String getFingerPrint() => _sysInfo[MobileSystemInfoTags.Fingerprint];

  @override
  String getHost() => _sysInfo[MobileSystemInfoTags.Host];

  @override
  String getManufacturer() => _sysInfo[MobileSystemInfoTags.Manufacturer];

  @override
  String getModel() => _sysInfo[MobileSystemInfoTags.Model];

  @override
  File getPrivateFolder() {
    Err.throwNotImplementedYet();
    return null;
  }

  @override
  String getSerial() => _sysInfo[MobileSystemInfoTags.Serial];

  @override
  String getVersionRelease() => _sysInfo[MobileSystemInfoTags.Release];
}
