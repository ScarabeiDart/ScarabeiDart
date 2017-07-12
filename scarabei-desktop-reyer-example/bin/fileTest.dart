import 'dart:io' as dart;

import 'package:path/path.dart' as path;
import 'package:scarabei_api/collections/collections.dart';
import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/strings/strings.dart';
import 'package:scarabei_api/sys/sys.dart';
import 'package:scarabei_api/utils/jutils.dart';
import 'package:scarabei_desktop_reyer/sys/desktop_system.dart';
import 'package:scarabei_reyer/collections/reyer_collections.dart';
import 'package:scarabei_reyer/debug/reyer_debug.dart';
import 'package:scarabei_reyer/error/reyer_error.dart';
import 'package:scarabei_reyer/files/win/win_file_system.dart';
import 'package:scarabei_reyer/log/reyer_logger.dart';
import 'package:scarabei_reyer/strings/red_strings.dart';
import 'package:scarabei_reyer/utils/red_utils.dart';

main() {
  dart.File f;
  L.installComponent(new ReyerLogger());
  Err.installComponent(new ReyerError());
  Debug.installComponent(new ReyerDebug());
  Collections.installComponent(new ReyerCollections());
  Utils.installComponent(new RedUtils());
  LocalFileSystem.installComponent(new WinFileSystem());
  Strings.installComponent(new RedStrings());
  Sys.installComponent(new DesktopSystem());
  path.basename("");

  var file = new dart.File("");
  String abs = file.absolute.path;

//  L.d("file", file);
//  L.d("root", path.rootPrefix(abs));
//  File c = LocalFileSystem.ApplicationHome().child("123.txt");
//  L.d("home", c.toString());
//  L.d("dart", c.toDartFile());

  File d = LocalFileSystem.invoke().newLocalFile(new dart.File("D:/"));

  var filter = (f) => f.getAbsoluteFilePath().getRelativePath().size() <= 2;
  var list = d.listAllChildren(fileFilter: filter);
  L.d("list", list);
  LocalFileSystem.ROOT();
  File h = LocalFileSystem.ApplicationHome();
  L.d("root", LocalFileSystem.ROOT());
  L.d("home", h);
  L.d("home-1", h.parent());
  L.d("home-2", h.parent().parent());
  L.d("home-3", h.parent().parent().parent());
  L.d("home-4", h.parent().parent().parent().parent());
  var h0 = h.parent().parent().parent().parent();
  var root = LocalFileSystem.ROOT();
  var eq = h0 == root;
  L.d("h0 == root", eq);
//  L.d("home-5", h.parent().parent().parent().parent().parent());

//  L.d("home", LocalFileSystem.ApplicationHome());
//  L.d("home", LocalFileSystem.ApplicationHome().listAllChildren());

  L.d("root", LocalFileSystem.ROOT());
  L.d("D:", LocalFileSystem.ROOT().child("D:").listAllChildren(fileFilter: filter));
  L.d("root", LocalFileSystem.ROOT().listAllChildren(fileFilter: filter));
//


//  L.d("home", LocalFileSystem.ApplicationHome().listAllChildren());

//  path.separator
}