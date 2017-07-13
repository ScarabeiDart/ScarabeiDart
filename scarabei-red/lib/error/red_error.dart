import 'package:scarabei_api/error/err.dart';

class RedError extends ErrorComponent {


  @override
  void reportError(String message, [Error e]) {
    if (e != null) {
      throw new StateError(message + " exception: $e");
    } else {
      throw new StateError(message);
    }
  }

  @override
  void reportNotImplementedYet() {
    throw new StateError("Not implemented yet!");
  }
}
