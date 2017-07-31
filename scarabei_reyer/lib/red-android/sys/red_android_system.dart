import 'dart:async';

import 'package:scarabei/api-android/android.dart';
import 'package:scarabei/api/sys/system_info.dart';
import 'package:scarabei_reyer/red/sys/red_system.dart';

class RedAndroidSystem extends RedSystem {
  @override
  Future<SystemInfo> getSystemInfo() {
    return Android.getSystemInfo();
  }
}