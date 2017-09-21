import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/scarabei.dart';

class RedError extends ErrorComponent {
  @override
  void reportError(Object message, [Error e]) {
    String err_message;
    if (e != null) {
      err_message = (message.toString() + " exception: $e");
    } else {
      err_message = (message.toString());
    }

    if (SystemSettings.executionModeIsAtLeast(ExecutionMode.TESTING)) {
      throw new StateError(err_message);
    } else {
      L.e(err_message);
    }
  }

  @override
  void reportNotImplementedYet() {
    String message = "Not implemented yet!";
    if (SystemSettings.executionModeIsAtLeast(ExecutionMode.TESTING)) {
      throw new StateError(message);
    } else {
      L.e(message);
    }
  }
}
