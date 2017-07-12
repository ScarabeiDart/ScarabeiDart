import 'package:scarabei_api/sys/on_exit_listener.dart';
import 'package:scarabei_api/sys/system_info.dart';
import 'package:scarabei_api/time/time_stream.dart';

abstract class SystemComponent {

  TimeStream SystemTime();

  TimeStream NoTime();

  void exit();

  bool sleep(int period);

  bool isWindows();

  bool isUnix();

  bool isMac();

  SystemInfo getSystemInfo();

  void yeld();

  void wait(Object lock);

  void addOnExitListener(OnExitListener listener);

  bool isIOS();

  int currentTime();
}
