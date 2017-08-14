import 'package:scarabei/api/names/names.dart';
import 'package:scarabei_reyer/red/sys/red_system.dart';
import 'package:scarabei/api-flutter/mobile_device.dart';
class FlutterSystem extends RedSystem {
  @override
  Map<ID, String> getSystemInfo() {
    return MobileDevice.getSystemInfo();
  }
}
