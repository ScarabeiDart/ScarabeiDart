import 'dart:async';

import 'package:scarabei/api/codec/codecs.dart';
import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/cross-platform/method_call.dart';
import 'package:scarabei/api/cross-platform/method_result.dart';
import 'package:scarabei/api/cross-platform/transport.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';

class FlutterCrossPlatformCalls implements CrossPlatformCallsComponent {
  Transport _transport;

  FlutterCrossPlatformCalls(Transport transport) {
    _transport = Debug.checkNull(transport, "transport");
  }

  ID channelID = Names.newID(string: "com.jfixby.scarabei.red.flutter.calls.FlutterJavaCallListener");

  //-----------------------

  @override
  Future<dynamic> makeCall(CallSpecs specs) async {
    ID callID = specs.callID;
    Debug.checkNull(callID, "callID");
    if (specs.arguments == null) {
      specs.arguments = [];
    }
    MethodCall call = new MethodCall();
    call.methodName = callID;
    call.callArguments = specs.arguments;

    Map<String, dynamic> encodedMethod = Codecs.encode(call);
//    L.d("encodedMethod", encodedMethod);
    var json = Json.serializeToString(encodedMethod);
//    L.d("encodedMethodJson " + callID.toString(), json.toString().replaceAll("\n", ""));

    String channelResultJson = await _transport.invokeMethod('invoke', {"json": json.toString()});

//    L.d("channelResultJson", channelResultJson);

    Map<String, dynamic> encodedResult = Json.deserializeFromString(rawString: channelResultJson);

    MethodResult flutterObject = Codecs.decode(encodedResult);

//    L.d("result.methodName", flutterObject.methodName);
//    L.d("result.success", flutterObject.success);
//    L.d("result.errorMessage", flutterObject.error);
//    L.d("result.resultingObject", flutterObject.result);
//
//    L.d("result map", flutterObject);
    if (flutterObject.success) {
      return flutterObject.result;
    } else {
      L.e(" request", json.toString().replaceAll("\n", ""));
      L.e("response", channelResultJson);
      throw new Exception(flutterObject.error);
    }
  }

  Future<dynamic> _invoke(Map<String, dynamic> call) {
//    L.d("invoke", Json.serializeToString(call));
    return _transport.invokeMethod('invoke', call);
  }

  @override
  CallSpecs newCallSpecs() {
    return new CallSpecs();
  }
}
