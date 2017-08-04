import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';

class RedError extends ErrorComponent {
  @override
  void reportError(String message, [Error e]) {
//    L.e(message);
    if (e != null) {
      throw new StateError(message + " exception: $e");
    } else {
      throw new StateError(message);
    }
  }

  @override
  void reportNotImplementedYet() {
    String message = "Not implemented yet!";
//    L.e(message);
    throw new StateError(message);
  }
}
