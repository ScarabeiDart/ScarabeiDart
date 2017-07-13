import 'package:scarabei_api/collections/collections.dart';
import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_red/collections/red_collections.dart';
import 'package:scarabei_red/debug/red_debug.dart';
import 'package:scarabei_red/error/red_error.dart';
import 'package:scarabei_red/log/red_logger.dart';

main() {
  L.installComponent(new RedLogger());
  Err.installComponent(new RedError());
  Debug.installComponent(new RedDebug());
  Collections.installComponent(new RedCollections());

  List<String> list = Collections.newList();
  list.add("A");
  list.add("B");
  list.add("C");
  L.d("list", list);

  Map<String, String> map = Collections.newMap();
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

