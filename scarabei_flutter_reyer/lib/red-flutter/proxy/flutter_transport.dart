import 'dart:async';

import 'package:flutter/src/services/platform_channel.dart';
import "package:scarabei/api/cross-platform/transport.dart";
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/names/names.dart';

class FlutterTransport implements Transport {
  MethodChannel _channel;

  FlutterTransport(ID channelID) {
    _channel = new MethodChannel(channelID.toString());
  }

  @override
  Future<dynamic> invokeMethod(String callName, Map<String, dynamic> arguments) {
//    L.d("sending call[" + callName + "] " + _channel.toString(), arguments);
    return _channel.invokeMethod(callName, arguments);
  }
}
