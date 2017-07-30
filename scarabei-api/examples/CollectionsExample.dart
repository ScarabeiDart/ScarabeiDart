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

//  var context = new path.Context(style: Style.posix);
//  context.join("directory", "file.txt");
//  context.
//  L.d("map", map);
//  list.print("list");
}

