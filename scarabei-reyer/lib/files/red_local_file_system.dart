import 'dart:io' as dart;

import 'package:path/path.dart' as path;
import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file.dart';
import "package:scarabei_api/files/file_system.dart";
import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/relative_path.dart';
import 'package:scarabei_api/utils/jutils.dart';
import 'package:scarabei_reyer/files/abstract_file_system.dart';
import 'package:scarabei_reyer/files/local_red_file.dart';

class RedLocalFileSystem extends AbstractFileSystem
    implements LocalFileSystemComponent {


//  FileOutputStream newFileOutputStream(File output_file, {bool append = false}) {
//    Debug.checkNull(output_file, "File");
//    Debug.checkTrue(output_file.getFileSystem() == this, "File belongs to this filesystem?");
//    return new JavaFileOutputStream(output_file.toJavaFile(), append);
//  }

//  AbsolutePath<FileSystem> resolve(dart.File file) {
//    Debug.checkNull(file, "file");
//    file = file.absolute;
//    RelativePath relative = this.pathToRelative(file.toPath());
//    AbsolutePath<FileSystem> path = Utils.newAbsolutePath(this, relative);
//    return path;
//  }

//  RelativePath pathToRelative(java_nio_file_Path path) {
//    List<String> steps = new List();
//    for (java_nio_file_Path p in path) {
//      steps.add(p.toFile().getName());
//    }
//    RelativePath relative = Utils.newRelativePath(steps);
//    return relative;
//  }

  File newFile(AbsolutePath<FileSystem> file_path) {
    Debug.checkNull(file_path, "file_path");
    if (file_path.getMountPoint() != this) {
      L.e("file_path", file_path);
      L.e("FileSystem", file_path.getMountPoint());
      Err.reportError("Path does not belong to this filesystem: " + this.toString());
    }
    return new LocalRedFile(file_path, this);
  }

  File newLocalFile({dart.File dartFile, String dart_file_path}) {
    if (dartFile != null) {
      dart_file_path = dartFile.absolute.path;
    }
    Debug.checkNull("dart_file_path", dart_file_path);
//    String splitRegex = Pattern.quote(System.getProperty("file.separator"));
    Pattern splitRegex = path.separator;
    RelativePath splittedFileName = Utils.newRelativePath(path_steps: (dart_file_path.split(splitRegex)));
    File file = this.ROOT().proceed(splittedFileName);
    return file;
  }


  File ApplicationHome() {
    path.basename("");
    return this.newLocalFile(dart_file_path: application_home_path_string);
  }

  final String application_home_path_string = new dart.File("").absolute.path;
}
