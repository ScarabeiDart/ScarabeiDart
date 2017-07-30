import 'dart:async';

import 'package:scarabei_api/api-android/android.dart';
import 'package:scarabei_api/api/sys/system_info.dart';
import 'package:scarabei_api/red/sys/red_system.dart';

class RedAndroidSystem extends RedSystem {
  @override
  Future<SystemInfo> getSystemInfo() {
    return Android.getSystemInfo();
  }
}