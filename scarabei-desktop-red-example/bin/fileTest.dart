import 'dart:io' as dart;

import 'package:path/path.dart' as path;
import 'package:scarabei_api/collections/collections.dart';
import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/strings/strings.dart';
import 'package:scarabei_api/sys/settings/system_settings.dart';
import 'package:scarabei_api/sys/sys.dart';
import 'package:scarabei_api/utils/jutils.dart';
import 'package:scarabei_desktop_red/sys/red_desktop_system.dart';
import 'package:scarabei_red/collections/red_collections.dart';
import 'package:scarabei_red/debug/red_debug.dart';
import 'package:scarabei_red/error/red_error.dart';
import 'package:scarabei_red/files/win/win_file_system.dart';
import 'package:scarabei_red/log/red_logger.dart';
import 'package:scarabei_red/strings/red_strings.dart';
import 'package:scarabei_red/sys/red_system_settings.dart';
import 'package:scarabei_red/utils/red_utils.dart';

main() {
  dart.File f;
  L.installComponent(new RedLogger());
  Err.installComponent(new RedError());
  Debug.installComponent(new RedDebug());
  Collections.installComponent(new RedCollections());
  Utils.installComponent(new RedUtils());
  LocalFileSystem.installComponent(new WinFileSystem());
  Strings.installComponent(new RedStrings());
  Sys.installComponent(new RedDesktopSystem());
  SystemSettings.installComponent(new RedSystemSettings());
  path.basename("");

  var file = new dart.File("");
  String abs = file.absolute.path;


//  var sink = dartFile.openWrite();
//  sink.write('FILE ACCESSED ${new DateTime.now()}\n');

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

  L.d("sys", SystemSettings.listAllSettings());
//  L.d("home", LocalFileSystem.ApplicationHome().listAllChildren());

//  path.separator
}

//void writeAsBytesSync(List<int> bytes,
//    {FileMode mode: FileMode.WRITE, bool flush: false}) {
//  dar.File f = null;
//  RandomAccessFile opened = f.openSync(mode: mode);
//  try {
//    opened.writeFromSync(bytes, 0, bytes.length);
//    if (flush) opened.flushSync();
//  } finally {
//    opened.closeSync();
//  }
//}