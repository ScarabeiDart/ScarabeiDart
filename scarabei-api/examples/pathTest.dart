import 'package:scarabei_api/api/debug/debug.dart';
import 'package:scarabei_api/api/error/err.dart';
import 'package:scarabei_api/api/files/local_file_system.dart';
import 'package:scarabei_api/api/log/logger.dart';
import 'package:scarabei_api/api/utils/utils.dart';
import 'package:scarabei_api/red/debug/red_debug.dart';
import 'package:scarabei_api/red/error/red_error.dart';
import 'package:scarabei_api/red/log/red_logger.dart';
import 'package:scarabei_api/red/utils/red_utils.dart';

main() {
  L.installComponent(new RedLogger());
  Err.installComponent(new RedError());
  Debug.installComponent(new RedDebug());
  Utils.installComponent(new RedUtils());
  LocalFileSystem.installComponent(null);

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

  var relative = Utils.newRelativePath(relative_path_string: "1/2/3");
  var relativeB = Utils.newRelativePath();
  relativeB = relativeB.child("1");
  relativeB = relativeB.child("2");
  relativeB = relativeB.child("3");
  L.d("relative", relative);
  L.d("relativeB", relativeB);
  bool eq = relativeB == (relative);
  L.d("eq", eq);
  relativeB = relativeB.child("4");
  L.d("relativeB", relativeB);
  L.d("a", relativeB.beginsWith(relative));
  L.d("b", relative.beginsWith(relativeB));

//  var context = new path.Context(style: Style.posix);
//  context.join("directory", "file.txt");
//  context.
//  L.d("map", map);
//  list.print("list");
}

//abstract class FileSystem {}
//
//abstract class LocalFileSystem extends FileSystem {}
//
//abstract class AbstractFileSystem extends FileSystem {}
//
//abstract class ImplementationOfALocalFileSystem extends AbstractFileSystem implements LocalFileSystem {}