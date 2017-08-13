import 'package:scarabei/api/cross-platform/flutter_to_cross_language_encoder.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

class FlutterPrimitivesToCrossLanguageEncoder implements FlutterToCrossLanguageEncoder {
  bool canEncode(Object flutterObject) {
    if (flutterObject == null) {
      return true;
    }
    if (flutterObject is ExecutionMode) {
      return true;
    }
    if (flutterObject is ID) {
      return true;
    }
    if (flutterObject is String) {
      return true;
    }
    if (flutterObject is bool) {
      return true;
    }
    if (flutterObject is int) {
      return true;
    }
    if (flutterObject is Map) {
      return true;
    }
    if (flutterObject is Iterable) {
      return true;
    }
    return false;
  }

  Object encode(Object flutterObject) {
    if (flutterObject == null) {
      return null;
    }
    if (flutterObject is ExecutionMode) {
      return flutterObject.toString();
    }
    if (flutterObject is ID) {
      return flutterObject.toString();
    }
    if (flutterObject is String) {
      return flutterObject;
    }
    if (flutterObject is bool) {
      return flutterObject;
    }
    if (flutterObject is int) {
      return flutterObject;
    }
    if (flutterObject is Map) {
      return flutterObject;
    }
    if (flutterObject is Iterable) {
      return flutterObject;
    }

    Err.reportError("Failed to encode <" + flutterObject + ">");
    return null;
  }
}
