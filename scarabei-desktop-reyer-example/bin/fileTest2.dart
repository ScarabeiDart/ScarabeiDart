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
import 'package:scarabei_desktop_reyer/sys/desktop_system.dart';
import 'package:scarabei_reyer/collections/reyer_collections.dart';
import 'package:scarabei_reyer/debug/reyer_debug.dart';
import 'package:scarabei_reyer/error/reyer_error.dart';
import 'package:scarabei_reyer/files/win/win_file_system.dart';
import 'package:scarabei_reyer/log/reyer_logger.dart';
import 'package:scarabei_reyer/strings/red_strings.dart';
import 'package:scarabei_reyer/sys/red_system_settings.dart';
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
  SystemSettings.installComponent(new RedSystemSettings());
  path.basename("");

  File home = LocalFileSystem.ApplicationHome();
  L.d("home", home.listAllChildren());

  File licenseFile = home.child("LICENSE");
  L.d("licenseFile", licenseFile);
  String stringData = licenseFile.readString();
  L.d("stringData", stringData);
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