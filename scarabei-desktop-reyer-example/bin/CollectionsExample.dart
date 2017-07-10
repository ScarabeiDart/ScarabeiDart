import 'package:scarabei_api/collections/collections.dart';
import 'package:scarabei_api/collections/list.dart';
import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_reyer/collections/reyer_collections.dart';
import 'package:scarabei_reyer/debug/reyer_debug.dart';
import 'package:scarabei_reyer/error/reyer_error.dart';
import 'package:scarabei_reyer/log/reyer_logger.dart';

main() {
  L.installComponent(new ReyerLogger());
  Err.installComponent(new ReyerError());
  Debug.installComponent(new ReyerDebug());
  Collections.installComponent(new ReyerCollections());

  SList<String> list = Collections.newList();
  list.add("A");
  list.add("B");
  list.add("C");
//  list.print("list");
}

