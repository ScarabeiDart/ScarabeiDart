import 'dart:async';

import 'package:flutter/src/services/platform_channel.dart';
import 'package:scarabei/api/cross-platform/cross_language_to_flutter_decoder.dart';
import 'package:scarabei/api/cross-platform/cross_platform_call_result.dart';
import "package:scarabei/api/cross-platform/cross_platform_calls.dart";
import 'package:scarabei/api/cross-platform/flutter_to_cross_language_encoder.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei_flutter_reyer/red-flutter/cross_language_to_flutter_primitives_decoder.dart';
import 'package:scarabei_flutter_reyer/red-flutter/cross_language_to_scarabei_decoder.dart';
import 'package:scarabei_flutter_reyer/red-flutter/decoders.dart';
import 'package:scarabei_flutter_reyer/red-flutter/encoders.dart';
import 'package:scarabei_flutter_reyer/red-flutter/flutter_primitives_to_cross_language_encoder.dart';
import 'package:scarabei_flutter_reyer/red-flutter/method_call_encoder.dart';
import 'package:scarabei_flutter_reyer/red-flutter/scarabei_to_cross_language_encoder.dart';

class FlutterCrossPlatformCalls implements CrossPlatformCallsComponent {
  static const MethodChannel _channel = const MethodChannel("com.jfixby.scarabei.red.flutter.calls.RedFlutterCalls");
  Encoders encoders = new Encoders();
  Decoders decoders = new Decoders();

  FlutterCrossPlatformCalls() {
    this.registerDecoder(new CrossLanguageToFlutterPrimitivesDecoder());
    this.registerDecoder(new CrossLanguageToScarabeiDecoder());
    this.registerEncoder(new ScarabeiToCrossLanguageEncoder());
    this.registerEncoder(new FlutterPrimitivesToCrossLanguageEncoder());
  }

  void registerEncoder(FlutterToCrossLanguageEncoder encoder) {
    this.encoders.register(encoder);
  }

  void registerDecoder(CrossLanguageToFlutterDecoder decoder) {
    this.decoders.registerDecoder(decoder);
  }

  Object encode(Object javaObject) {
    return this.encoders.encode(javaObject);
  }

  Object decode(Object encodedObject, Map<Object, String> objectTypeNames) {
    return this.decoders.decode(encodedObject, objectTypeNames);
  }

  dynamic decodeMethodCallResult(CrossPlatformCallResult callResult) {
    dynamic flutterObject = this.decode(callResult.resultObject, callResult.objectTypeNames);
    return flutterObject;
  }

  //-----------------------

  @override
  Future<CallResult> makeCall(CallSpecs specs) async {
    CallResult result = new CallResult();
    ID callID = specs.callID;
    Debug.checkNull(callID, "callID");
    if (specs.arguments == null) {
      specs.arguments = [];
    }
    var arguments = [];
    for (CallArgument argument in specs.arguments) {
      MethodCallEncoder.encodeArgument(arguments,
          name: argument.argumentName, value: argument.argumentValue, type: argumentType);
    }

    MethodCallEncoder.encodeMethod(callID, arguments);

    return result;
  }

  Future<dynamic> _invoke(Map<String, dynamic> call) {
    L.d("invoke", Json.serializeToString(call));
    return _channel.invokeMethod('invoke', call);
  }

  @override
  CallSpecs newCallSpecs() {
    return new CallSpecs();
  }
}
