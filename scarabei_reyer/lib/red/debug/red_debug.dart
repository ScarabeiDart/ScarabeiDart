import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/debug/state_switcher.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/red/debug/red_state_switcher.dart';
import 'package:scarabei_reyer/scarabei_reyer.dart';

class RedDebug extends DebugComponent {
  AssertionsChecker checker;

  RedDebug({AssertionsChecker checker}) {
    if (checker == null) {
      checker = new ProductionAssetionsChecker();
    }
    this.checker = checker;
  }

  @override
  StateSwitcher<T> newStateSwitcher<T>(T default_state) {
    return new RedStateSwitcher<T>(default_state);
  }

  @override
  void printStackTrace() {
    StackTrace stack = StackTrace.current;
    L.d(stack);
  }

  @override
  DebugTimer newDebugTimer() {
    return new RedDebugTimer();
  }

  @override
  String checkEmpty(String string, [String name]) => checker.checkEmpty(string, name);

  @override
  T checkNull<T>(T obj, [String name]) => checker.checkNull(obj, name);

  @override
  void checkTrue(bool value, [String name]) => checker.checkTrue(value, name);
}

class RedDebugTimer implements DebugTimer {
  int last;

  RedDebugTimer() {
    reset();
  }

  @override
  void reset() {
    this.last = Sys.currentTime();
  }

  @override
  DebugTimerTimestamp timestamp(String tag, [int threshold = -1]) {
    int delta = Sys.currentTime() - last;
    RedDebugTimerTimestamp timestamp = new RedDebugTimerTimestamp();
    timestamp.delta = delta;
    timestamp.tag = tag;
    timestamp.threshold = threshold;

    return timestamp;
  }
}

class RedDebugTimerTimestamp implements DebugTimerTimestamp {
  int delta;

  String tag;

  int threshold;

  @override
  String toString() {
    if (delta > threshold) {
      return "DebugTimer: $tag > $delta";
    }
    return "DebugTimer: $tag";
  }
}
