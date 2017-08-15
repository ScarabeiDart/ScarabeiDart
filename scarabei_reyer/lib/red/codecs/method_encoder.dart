import 'package:scarabei/api/codec/codecs.dart';
import 'package:scarabei/api/codec/from_dart_encoder.dart';
import 'package:scarabei/api/cross-platform/class_names.dart';
import 'package:scarabei/api/cross-platform/method_argument.dart';
import 'package:scarabei/api/cross-platform/method_call.dart';
import 'package:scarabei/api/error/err.dart';

class MethodEncoder implements FromDartEncoder {
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
      map[MethodArgument.METHOD_ARGUMENT_NAME] = Codecs.encode(flutterObject.argumentName);
      map[MethodArgument.METHOD_ARGUMENT_VALUE] = Codecs.encode(flutterObject.argumentValue);
      return EncodedObject.encodeObject(value: map, type: CrossLanguageClassNames.MethodCallArgument);
    }

    if (flutterObject is MethodCall) {
      Map<String, dynamic> mE = {};
      mE[MethodCall.METHOD_NAME] = Codecs.encode(flutterObject.methodName);
      mE[MethodCall.METHOD_ARGUMENTS] = Codecs.encode(flutterObject.callArguments);
      return EncodedObject.encodeObject(value: mE, type: CrossLanguageClassNames.MethodCall);
    }

    Err.reportError("Failed to encode <" + flutterObject + ">");
    return null;
  }
}
