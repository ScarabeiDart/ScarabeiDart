import 'package:scarabei_api/api/debug/debug.dart';
import 'package:scarabei_api/api/error/err.dart';
import 'package:scarabei_api/api/log/logger.dart';
import 'package:scarabei_api/red/debug/red_debug.dart';
import 'package:scarabei_api/red/error/red_error.dart';
import 'package:scarabei_api/red/log/red_logger.dart';
main() {
  L.installComponent(new RedLogger());
  Err.installComponent(new RedError());
  Debug.installComponent(new RedDebug());


  L.d("Hello!");
  L.d("Hello", "fuck you");

  Debug.checkNull("ssss");
//  Debug.checkNull(null, "x");

  Debug.checkTrue(false, "b");
}




