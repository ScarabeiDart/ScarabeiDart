import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/json/json_string.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/sys/settings/system_settings.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei_reyer/red-android/sys/red_android_system.dart';
import 'package:scarabei_reyer/red/debug/red_debug.dart';
import 'package:scarabei_reyer/red/error/red_error.dart';
import 'package:scarabei_reyer/red/json/dart_json.dart';
import 'package:scarabei_reyer/red/log/simple_logger.dart';
import 'package:scarabei_reyer/red/sys/red_system_settings.dart';

main() {
  L.installComponent(new SimpleLogger());
  Err.installComponent(new RedError()); //errors reporter
  Debug.installComponent(new RedDebug()); // asserts for debug and testing
  Sys.installComponent(new RedAndroidSystem()); //...
  SystemSettings.installComponent(new RedSystemSettings()); //...
  SystemSettings.setExecutionMode(ExecutionMode.EARLY_DEVELOPMENT);
  Json.installComponent(new DartJson());
//  Json.installComponent(new Dson());
  L.d("hello");
  L.e("hello");

  List<String> list = [];
  list.add("A");
  list.add("B");
  list.add("C");
//  L.d("list", list);

  Map<String, String> map = {};
  map.addAll({"A": "1"});
  map.addAll({"B": "2"});
  map.addAll({"C": "3"});

//  L.d("map", map);

  list = Json.deserializeFromString(json: test("list", list));
  L.d("list", list);
  map = Json.deserializeFromString(json: test("map", map));
  L.d("map", map);
//  test("TestClass", new TestClass());
//  test("TestClassB", new TestClassB());
}

JsonString test(String tag, Object obj) {
  JsonString json = Json.serializeToString(obj);
  L.d(tag, json);
  return json;
}

class TestClass {
  String bob = "s bob";
  String bob2 = "s bob2";
  bool bt = false;
  bool bf = true;
  int five = 5;
  int six = 6;
}

class TestClassB {
  String bob = "s bob";
  String bob2 = "s bob2";
  bool bt = false;
  bool bf = true;
  int five = 5;
  int six = 6;

  TestClass tc = new TestClass();
}
