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
import 'package:scarabei_api/strings/strings.dart';
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

  File newLocalFile(dart.File dartFile) {
    Debug.checkNull(dartFile, "dartFile");

    if (!dartFile.isAbsolute) {
      dartFile = dartFile.absolute;
    }
//
//    String rootPrefix = path.rootPrefix(application_home_path_string);
//    if (dart_file_path.startsWith(rootPrefix)) {
//      dart_file_path = dart_file_path.substring(dart_file_path.length);
//    }

    Pattern splitRegex = path.separator;
    RelativePath splittedFileName = Utils.newRelativePath(path_steps: (dartFile.path.split(splitRegex)));
    File file = this.ROOT().proceed(splittedFileName);
    return file;
  }

  String dartFilePath(AbsolutePath<FileSystem> absolute_path) {
//    if (absolute_path.isRoot()) {
//      String dartPath = path.rootPrefix(application_home_path_string);
//      return new dart.File(dartPath).absolute.path;
//    }
    RelativePath relative = absolute_path.getRelativePath();
    Pattern splitRegex = path.separator;
    String dartPath = Strings.wrapSequence(relative.steps(), "", "", splitRegex.toString());
//    L.d("dartPath", dartPath);
//    Sys.exit();
    var result = new dart.File(dartPath).path;
    return result;
  }


  File ApplicationHome() {
    return this.newLocalFile(new dart.File("").absolute);
  }

//  final String application_home_path_string = new dart.File("").absolute.path;


}
