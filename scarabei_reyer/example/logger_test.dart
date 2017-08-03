import 'package:logging/logging.dart';
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei_reyer/red-android/sys/red_android_system.dart';
import 'package:scarabei_reyer/red/debug/red_debug.dart';
import 'package:scarabei_reyer/red/error/red_error.dart';
import 'package:scarabei_reyer/red/log/pub_logging.dart';
import 'package:scarabei_reyer/red/log/simple_logger.dart';
import 'package:scarabei_reyer/red/sys/red_system_settings.dart';

import 'again.dart';

void loggerListener(LogRecord record) {
  {
    var left = (record.level.toString() + " " + record.loggerName.toString()).padLeft(90, ' ');
    print(left + "| " + record.message);
    if (record.error != null) {
      print(record.error.toString());
    }
    if (record.stackTrace != null) {
      print(record.stackTrace.toString());
    }
  }
}

main() {
  PubLogging logging = new PubLogging();
  logging.setupRootListener(loggerListener);
  L.installComponent(new SimpleLogger(logging));
  Err.installComponent(new RedError()); //errors reporter
  Debug.installComponent(new RedDebug()); // asserts for debug and testing
  Sys.installComponent(new RedAndroidSystem()); //...
  SystemSettings.installComponent(new RedSystemSettings()); //...
  SystemSettings.setExecutionMode(ExecutionMode.EARLY_DEVELOPMENT);

  L.d("hello");
  L.e("hello");

  List<String> list = [];
  list.add("A");
  list.add("B");
  list.add("C");
  L.d("list", list);

  Map<String, String> map = {};
  map.addAll({"A": "1"});
  map.addAll({"B": "2"});
  map.addAll({"C": "3"});

  L.d("map", map);

  Again.again();
}
