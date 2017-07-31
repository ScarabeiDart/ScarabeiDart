library com.jfixby.scarabei.red.sys;

import 'dart:io' as dart;

import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/sys/on_exit_listener.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei/api/time/time_stream.dart';
import 'package:scarabei_reyer/red/sys/no_clock.dart';
import 'package:scarabei_reyer/red/sys/os_validator.dart';
import 'package:scarabei_reyer/red/sys/system_clock.dart';

abstract class RedSystem implements SystemComponent {

  RedSystem() {
  }
  static SystemClock system_clock = new SystemClock();
  static NoClock no_clock = new NoClock();

  TimeStream SystemTime() {
    return system_clock;
  }

  TimeStream NoTime() {
    return no_clock;
  }

  bool isWindows() {
    return OSValidator.isWindows();
  }

  bool isUnix() {
    return OSValidator.isUnix();
  }

  bool isMac() {
    return OSValidator.isMac();
  }

  bool isIOS() {
    return OSValidator.isIOS();
  }


  List<OnExitListener> onExitListeners = [];

  void exit() {
    for (OnExitListener listener in this.onExitListeners) {
      listener.onExit();
    }
    print("EXIT");
    dart.exit(0);
//    System.exit(0);
  }

  void addOnExitListener(OnExitListener listener) {
    Debug.checkNull(listener, "listener");
    this.onExitListeners.add(listener);
  }

  @override
  int currentTime() {
    return system_clock.currentTimeMillis();
  }


}
