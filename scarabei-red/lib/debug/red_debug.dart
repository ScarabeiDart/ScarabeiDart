import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/debug/state_switcher.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_red/debug/red_state_switcher.dart';

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
  }
}
