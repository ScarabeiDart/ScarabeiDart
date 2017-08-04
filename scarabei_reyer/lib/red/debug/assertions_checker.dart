import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/debug/state_switcher.dart';
import 'package:scarabei_reyer/red/debug/red_state_switcher.dart';

class AssertionsChecker implements DebugComponent {
  @override
  T checkNull<T>(T obj, [String name]) {
    assert(obj != null);
    return obj;
  }

  @override
  void checkTrue(bool value, [String name]) {
    assert(value);
  }

  @override
  StateSwitcher<T> newStateSwitcher<T>(T default_state) {
    return new RedStateSwitcher<T>(default_state);
  }

  @override
  String checkEmpty(String string, [String name]) {
    assert("" != string);
    return string;
  }
}
