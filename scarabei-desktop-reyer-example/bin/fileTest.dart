import 'dart:io' as dart;

import 'package:path/path.dart' as path;
import 'package:scarabei_api/collections/collections.dart';
import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/utils/jutils.dart';
import 'package:scarabei_reyer/collections/reyer_collections.dart';
import 'package:scarabei_reyer/debug/reyer_debug.dart';
import 'package:scarabei_reyer/error/reyer_error.dart';
import 'package:scarabei_reyer/files/win/win_file_system.dart';
import 'package:scarabei_reyer/log/reyer_logger.dart';
import 'package:scarabei_reyer/utils/red_utils.dart';

main() {
  dart.File f;
  L.installComponent(new ReyerLogger());
  Err.installComponent(new ReyerError());
  Debug.installComponent(new ReyerDebug());
  Collections.installComponent(new ReyerCollections());
  Utils.installComponent(new RedUtils());
  LocalFileSystem.installComponent(new WinFileSystem());
  path.basename("");

  var file = new dart.File("");
  String abs = file.absolute.path;

  L.d("file", file);
  L.d("root", path.rootPrefix(abs));

  L.d("home", LocalFileSystem.ApplicationHome().listAllChildren());

//  path.separator
}