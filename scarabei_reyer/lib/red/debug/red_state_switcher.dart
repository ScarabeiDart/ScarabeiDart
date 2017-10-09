import 'package:scarabei/api/debug/state_switcher.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/scarabei.dart';

class RedStateSwitcher<T> extends StateSwitcher<T> {
  T state;
  String debug_name;

  RedStateSwitcher(T default_state) {
    this.debug_name = "StateSwitcher";
    this.switchState(default_state);
  }

  void expectState(T expected_state) {
    if (!(this.state == expected_state)) {
      String message =
          ((("Wrong state=" + this.state.toString()) + ", expected: ") +
              expected_state.toString());
      Err.reportError((this.debug_name + ": ") + message);
    }
  }

  String switchState(T next_state) {
    if (next_state == null) {
      Err.reportError((this.debug_name + ": ") + "Null state detected");
    }
    String msg =
        ((this.debug_name + ": ") + this.state.toString()) + " -> " + next_state.toString();
    if (this.debug) {
      L.d(msg);
    }
    this.state = next_state;
    return msg;
  }

  T currentState() {
    return this.state;
  }

  void setDebugName(String string) {
    this.debug_name = string;
  }

  bool debug = false;

  void setDebugFlag(bool b) {
    this.debug = b;
  }

  String toString() {
    return "<" + this.state.toString() + ">";
  }

  final bool throw_error = true;

  void doesNotExpectState(T unexpected_state) {
    if (this.state == unexpected_state) {
      String message = ("Unexpected state=" + this.state.toString());
      Err.reportError((this.debug_name + ": ") + message);
    }
  }

  bool stateIs(T state) {
    return this.currentState() == state;
  }
}
