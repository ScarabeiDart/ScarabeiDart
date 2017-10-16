import 'package:scarabei/scarabei.dart';

class ProductionAssetionsChecker implements AssertionsChecker {
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
}
