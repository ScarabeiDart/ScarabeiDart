import 'package:scarabei/scarabei.dart';

class ExecutionMode {
  static const ExecutionMode EARLY_DEVELOPMENT = const ExecutionMode._(3000, "EARLY_DEVELOPMENT");
  static const ExecutionMode TESTING = const ExecutionMode._(2000, "TESTING");
  static const ExecutionMode RELEASE_CANDIDATE = const ExecutionMode._(1000, "RELEASE_CANDIDATE");
  static const ExecutionMode DEMO = const ExecutionMode._(500, "DEMO");
  static const ExecutionMode PUBLIC_RELEASE = const ExecutionMode._(0, "PUBLIC_RELEASE");

  static const ExecutionMode defaultMode = ExecutionMode.PUBLIC_RELEASE;

  static String TAG = "com.jfixby.scarabei.ExecutionMode";

  @override
  String toString() {
    return _name;
  }

  static get values => [EARLY_DEVELOPMENT, TESTING, RELEASE_CANDIDATE, DEMO, PUBLIC_RELEASE];

  final int _value;
  final String _name;

  const ExecutionMode._(this._value, this._name);

  bool isAtLeast(ExecutionMode targetMode) => this._value >= targetMode._value;

  bool isBelow(ExecutionMode targetMode) => this._value < targetMode._value;

  static ExecutionMode resolve(exeString) {
    for (ExecutionMode ex in values) {
      if (ex.toString() == exeString) {
        return ex;
      }
    }
    L.e("Failed to resolve ExecutionMode", "[" + exeString + "]");
    L.e("           setting default mode", defaultMode);

    return defaultMode;
  }
}
