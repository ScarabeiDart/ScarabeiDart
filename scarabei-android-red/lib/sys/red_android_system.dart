import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/sys/system_info.dart';
import 'package:scarabei_android_api/android.dart';
import 'package:scarabei_red/sys/red_system.dart';

class RedAndroidSystem extends RedSystem {
  @override
  SystemInfo getSystemInfo() {
    return Android.getSystemInfo();
  }
}