import 'package:scarabei/api-android/android.dart';
import 'package:scarabei_reyer/red/sys/red_system.dart';

class RedAndroidSystem extends RedSystem {
  @override
  Map<String, String> getSystemInfo() {
    return Android.getSystemInfo();
  }
}