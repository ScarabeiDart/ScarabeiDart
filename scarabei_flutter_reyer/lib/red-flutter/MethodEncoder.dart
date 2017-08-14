import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/cross-platform/dart_to_cross_language_encoder.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/names/names.dart';

class MethodEncoder implements DartToCrossLanguageEncoder {
  bool canEncode(Object flutterObject) {
    if (flutterObject == null) {
      return true;
    }
    if (flutterObject is MethodArgument) {
      return true;
    }
    if (flutterObject is MethodCall) {
      return true;
    }
    return false;
  }

  @override
  Map<String, dynamic> encode(Object flutterObject) {
    if (flutterObject == null) {
      return EncodedObject.encodeNull();
    }

    if (flutterObject is MethodArgument) {
      Map<String, dynamic> map = {};
      map[MethodArgument.METHOD_ARGUMENT_NAME] = CrossPlatformCalls.encode(flutterObject.argumentName);
      map[MethodArgument.METHOD_ARGUMENT_VALUE] = CrossPlatformCalls.encode(flutterObject.argumentValue);
      return map;
    }

    if (flutterObject is MethodCall) {
      Map<String, dynamic> map = {};
      map[MethodCall.METHOD_NAME] = CrossPlatformCalls.encode(flutterObject.methodName);
      map[MethodCall.METHOD_ARGUMENTS] = CrossPlatformCalls.encode(flutterObject.callArguments);
      return map;
    }

    Err.reportError("Failed to encode <" + flutterObject + ">");
    return null;
  }
}

class MethodArgument {
  static const String METHOD_ARGUMENT_NAME = "argumentName";
  static const String METHOD_ARGUMENT_VALUE = "argumentValue";

  String argumentName;
  dynamic argumentValue;
}

class MethodCall {
  static const String METHOD_NAME = "methodName";
  static const String METHOD_ARGUMENTS = "methodArguments";

  ID methodName;
  List<MethodArgument> callArguments;
}
