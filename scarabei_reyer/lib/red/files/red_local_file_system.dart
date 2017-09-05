import 'dart:io' as dart;

import 'package:path/path.dart' as path;
import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/files/file_system.dart';
import 'package:scarabei/api/files/local_file_system.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/path/absolute_path.dart';
import 'package:scarabei/api/path/relative_path.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei/api/utils/utils.dart';
import 'package:scarabei_reyer/red/files/abstract_file_system.dart';
import 'package:scarabei_reyer/red/files/local_red_file.dart';

class RedLocalFileSystem extends AbstractFileSystem implements LocalFileSystemComponent {
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

  File newLocalFile(String dartFileString) {
    Debug.checkNull(dartFileString, "dartFile");
    dart.File dartFile = new dart.File(dartFileString);
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
    RelativePath relative = absolute_path.getRelativePath();
    Pattern splitRegex = path.separator;
    String dartPath;
    if (Sys.isWindows()) {
      dartPath = relative.steps().join(splitRegex.toString());
    } else {
      dartPath = splitRegex.toString() + relative.steps().join(splitRegex.toString());
    }
    var result = new dart.File(dartPath).path;
    return result;
  }

  File ApplicationHome() {
    return this.newLocalFile(new dart.File("").absolute.path);
  }

//  @override
//  Stream<List<int>> newInputStream(AbsolutePath<FileSystem> file_path) {
//    dart.File file = new dart.File(dartFilePath(file_path));
//    return file.openRead();
//  }
//
//  @override
//  dart.IOSink newOutputStream(AbsolutePath<FileSystem> file_path, {bool append}) {
//  }
}
