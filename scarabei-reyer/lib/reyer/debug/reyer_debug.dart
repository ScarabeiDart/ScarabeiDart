import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';

class ReyerDebug extends DebugComponent {
  @override
  void checkNull(Object obj, [String name]) {
    if (obj != null) {
      return;
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
}
