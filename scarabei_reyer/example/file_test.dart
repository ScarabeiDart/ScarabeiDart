import 'dart:io' as dart;

import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/files/local_file_system.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/strings/strings.dart';
import 'package:scarabei/api/sys/settings/system_settings.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei/api/utils/utils.dart';
import 'package:scarabei_reyer/red-desktop/sys/red_desktop_system.dart';
import 'package:scarabei_reyer/red/debug/red_debug.dart';
import 'package:scarabei_reyer/red/error/red_error.dart';
import 'package:scarabei_reyer/red/files/win/win_file_system.dart';
import 'package:scarabei_reyer/red/log/simple_logger.dart';
import 'package:scarabei_reyer/red/strings/red_strings.dart';
import 'package:scarabei_reyer/red/utils/red_utils.dart';
main() {
  dart.File f;
  L.installComponent(new SimpleLogger());
  Err.installComponent(new RedError());
  Debug.installComponent(new RedDebug());
  Utils.installComponent(new RedUtils());
  LocalFileSystem.installComponent(new WinFileSystem());
  Strings.installComponent(new RedStrings());
  Sys.installComponent(new DesktopSystem());

  var file = new dart.File("");
  String abs = file.absolute.path;


//  var sink = dartFile.openWrite();
//  sink.write('FILE ACCESSED ${new DateTime.now()}\n');

//  L.d("file", file);
//  L.d("root", path.rootPrefix(abs));
//  File c = LocalFileSystem.ApplicationHome().child("123.txt");
//  L.d("home", c.toString());
//  L.d("dart", c.toDartFile());

  File d = LocalFileSystem.invoke().newLocalFile("D:/");

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