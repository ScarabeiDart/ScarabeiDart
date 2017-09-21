import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/debug/state_switcher.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/red/debug/red_state_switcher.dart';

class RedDebug extends DebugComponent {
  @override
  T checkNull<T>(T obj, [String name]) {
    if (obj != null) {
      return obj;
    }
    if (name == null) {
      Err.reportError("Parameter is null");
    } else {
      Err.reportError("Parameter <$name> is null");
    }
    return null;
  }

  @override
  void checkTrue(bool value, [String name]) {
    if (value) {
      return;
    }
    if (name == null) {
      Err.reportError("Value is false");
    } else {
      Err.reportError("Value <$name> is false");
    }
  }

  @override
  StateSwitcher<T> newStateSwitcher<T>(T default_state) {
    return new RedStateSwitcher<T>(default_state);
  }

  @override
  String checkEmpty(String string, [String name]) {
    if (string != "") {
      return string;
    }
    if (name == null) {
      Err.reportError("String is empty");
    } else {
      Err.reportError("String <$name> is empty");
    }
    return null;
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
