import 'dart:async';

import 'package:scarabei_api/api/error/err.dart';
import 'package:scarabei_api/api/sys/system_info.dart';
import 'package:scarabei_api/red/sys/red_system.dart';

class RedDesktopSystem extends RedSystem {
  @override
  Future<SystemInfo> getSystemInfo() {
    Err.throwNotImplementedYet();
    return null;
  }
}