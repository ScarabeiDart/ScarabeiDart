import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei_reyer/red/debug/red_debug.dart';
import 'package:scarabei_reyer/red/error/red_error.dart';
import 'package:scarabei_reyer/red/log/simple_logger.dart';
main() {
  L.installComponent(new SimpleLogger());
  Err.installComponent(new RedError());
  Debug.installComponent(new RedDebug());


  L.d("Hello!");
  L.d("Hello", "fuck you");

  Debug.checkNull("ssss");
//  Debug.checkNull(null, "x");

  Debug.checkTrue(false, "b");
}




