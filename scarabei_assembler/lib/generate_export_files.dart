import 'dart:async';

import 'package:export_files_generator/export_files_generator.dart';
import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/scarabei_reyer.dart';

Future<dynamic> main(List<String> args) async {
  L.installComponent(new SimpleLogger());
  Err.installComponent(new RedError());
  Debug.installComponent(new RedDebug());
  Utils.installComponent(new RedUtils());
  Strings.installComponent(new RedStrings());
  Sys.installComponent(new DesktopSystem());
  SystemSettings.installComponent(new RedSystemSettings());

  if (Sys.isUnix()) {
    LocalFileSystem.installComponent(new UnixFileSystem());
  } else {
    LocalFileSystem.installComponent(new WinFileSystem());
  }
  SystemSettings.setExecutionMode(ExecutionMode.DEMO);

  bool dryRun = true;
  {
    if (args.contains("--dry-run")) {
      dryRun = true;
    } else {
      dryRun = false;
    }
  }
//  dryRun = true;
  await GenerateExportFiles.generateExportFiles(dryRun: dryRun);
}

class GenerateExportFiles {
  static Future<bool> generateExportFiles({bool dryRun = true}) async {
    File root = LocalFileSystem.ApplicationHome();
    String expected = "ScarabeiDart";
    if (root.getName() != expected) {
      root = root.parent();
    }
    if (root.getName() != expected) {
      Err.reportError("Wrong directory: $root. Expected folder name: $expected");
    }
    L.d("root", root);

    ExportFilesGenerator.generate(root, dryRun: dryRun);
  }
}
