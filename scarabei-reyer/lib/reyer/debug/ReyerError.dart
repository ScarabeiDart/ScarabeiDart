import 'package:scarabei_api/debug/Error.dart';

class ReyerError extends ErrorComponent {
  ReyerError() {}

  @override
  void reportError(String message, [Error e]) {
    throw new StateError(message + " exception: $e");
  }

  @override
  void reportNotImplementedYet() {
    throw new StateError("Not implemented yet!");
  }
}
