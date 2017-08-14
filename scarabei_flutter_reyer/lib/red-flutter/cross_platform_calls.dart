import 'dart:async';

import 'package:scarabei/api/codec/codecs.dart';
import 'package:scarabei/api/cross-platform/cross_platform_calls.dart';
import 'package:scarabei/api/cross-platform/method_argument.dart';
import 'package:scarabei/api/cross-platform/method_call.dart';
import 'package:scarabei/api/cross-platform/transport.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';

class FlutterCrossPlatformCalls implements CrossPlatformCallsComponent {
  Transport _transport;

  FlutterCrossPlatformCalls(Transport transport) {
    _transport = Debug.checkNull(transport,"transport");
    
  }

  ID channelID = Names.newID(raw_id_string: "com.jfixby.scarabei.red.flutter.calls.FlutterJavaCallListener");

  //-----------------------

  @override
  Future<CallResult> makeCall(CallSpecs specs) async {
    ID callID = specs.callID;
    Debug.checkNull(callID, "callID");
    if (specs.arguments == null) {
      specs.arguments = {};
    }
    MethodCall call = new MethodCall();
    call.methodName = callID;
    call.callArguments = [];
    for (String argName in specs.arguments.keys) {
      MethodArgument arg = new MethodArgument();
      arg.argumentName = argName;
      arg.argumentValue = specs.arguments[argName];
      call.callArguments.add(arg);
    }

    Map<String, dynamic> encodedMethod = Codecs.encode(call);
    L.d("encodedMethod", encodedMethod);
    var json = Json.serializeToString(encodedMethod);
    L.d("encodedMethodJson", json);

    String channelResultJson = await _transport.invokeMethod('invoke', {"json": json.toString()});

    L.d("channelResultJson", channelResultJson);

    Map<String, dynamic> encodedResult = Json.deserializeFromString(rawString: channelResultJson);

    Map<String, dynamic> flutterObject = Codecs.decode(encodedResult);

    L.d("result map", flutterObject);

    CallResult result = new CallResult();
    result.resultingObject = flutterObject["result"];
    result.errorMessage = flutterObject["errorMessage"];
    result.success = flutterObject["success"];
    return result;
  }

  Future<dynamic> _invoke(Map<String, dynamic> call) {
    L.d("invoke", Json.serializeToString(call));
    return _transport.invokeMethod('invoke', call);
  }

  @override
  CallSpecs newCallSpecs() {
    return new CallSpecs();
  }
}
