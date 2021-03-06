import 'dart:io' as dart;

import 'package:path/path.dart' as path;
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/files/local_file_system.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/strings/strings.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei/api/utils/utils.dart';
import 'package:scarabei_reyer/red-desktop/sys/red_desktop_system.dart';
import 'package:scarabei_reyer/red/debug/red_debug.dart';
import 'package:scarabei_reyer/red/error/red_error.dart';
import 'package:scarabei_reyer/red/files/posix/unix_file_system.dart';
import 'package:scarabei_reyer/red/files/virtual/in_memory_file_system.dart';
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
  LocalFileSystem.deInstallCurrentComponent();
  LocalFileSystem.installComponent(new UnixFileSystem());
  Strings.installComponent(new RedStrings());
  Sys.installComponent(new DesktopSystem());
  path.basename("");

  File home = LocalFileSystem.ApplicationHome();
  L.d("home", home.listAllChildren());

  File licenseFile = home.child("LICENSE");
  L.d("licenseFile", licenseFile);
  String stringData = licenseFile.readString();
  L.d("stringData", stringData);

  LocalFileSystem.setDeleteSwitch(deleteSwitchSafePosition: !true);
  File out = home.child("tmp").child("tmp1").child("tmp2");
  home.child("tmp").child("tmp1").child("tmp2").makeFolder();
  L.d("home", home.listAllChildren());

  LocalFileSystem.copyFileToFolder(licenseFile, out);
  File tmp = home.child("tmp");
  tmp.delete();

  InMemoryFileSystem fs = new InMemoryFileSystem();

  fs.ROOT();
  FileFilter x = null;
  fs.copyFilesTo(home.listAllChildren(fileFilter: x).toList(), fs.ROOT());

  L.d("in memory", fs.ROOT().listAllChildren());
  var data = fs.ROOT().child("LICENSE").readString();
  L.d("data", data);

  FileFilter g = (file) {
    return true;
  };
  FileFilter filter;
  filter = (file) {
    String name = file.getName();
    bool start = name.startsWith(".");
    return !start;
  };
  var root = fs.ROOT();
  var toCopy = root.listAllChildren(fileFilter: filter);
//  L.d("toCopy", toCopy);

  fs.copyFilesTo(toCopy.toList(), tmp);

  L.d("tmp", tmp.listAllChildren());
  tmp.delete();
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