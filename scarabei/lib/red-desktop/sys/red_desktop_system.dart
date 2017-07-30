import 'dart:async';

import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/sys/system_info.dart';
import 'package:scarabei/red/sys/red_system.dart';

class RedDesktopSystem extends RedSystem {
  @override
  Future<SystemInfo> getSystemInfo() {
    Err.throwNotImplementedYet();
    return null;
  }
}