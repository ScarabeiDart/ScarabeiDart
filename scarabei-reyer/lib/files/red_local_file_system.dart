import 'dart:io' as dart;

import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/file_output_stream.dart';
import "package:scarabei_api/files/file_system.dart";
import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/relative_path.dart';
import 'package:scarabei_api/utils/jutils.dart';
import 'package:scarabei_reyer/files/abstract_file_system.dart';

class RedLocalFileSystem extends AbstractFileSystem
    implements LocalFileSystemComponent {


  FileOutputStream newFileOutputStream(File output_file, {bool append = false}) {
    Debug.checkNull(output_file, "File");
    Debug.checkTrue(output_file.getFileSystem() == this, "File belongs to this filesystem?");
    return new JavaFileOutputStream(output_file.toJavaFile(), append);
  }

  AbsolutePath<FileSystem> resolve(dart.File file) {
    Debug.checkNull("file", file);
    file = file.getAbsoluteFile();
    RelativePath relative = this.pathToRelative(file.toPath());
    AbsolutePath<FileSystem> path = Utils.newAbsolutePath(this, relative);
    return path;
  }

  RelativePath pathToRelative(java_nio_file_Path path) {
    List<String> steps = new List();
    for (java_nio_file_Path p in path) {
      steps.add(p.toFile().getName());
    }
    RelativePath relative = Utils.newRelativePath(steps);
    return relative;
  }

  LocalRedFile newFile(AbsolutePath<FileSystem> file_path) {
    if (file_path == null) {
      Err.reportError("Filepath is null.");
    }
    if (file_path.getMountPoint() != this) {
      L.e("file_path", file_path);
      L.e("FileSystem", file_path.getMountPoint());
      Err.reportError("Path does not belong to this filesystem: " + this);
    }
    return new LocalRedFile(file_path, this);
  }

  File newLocalFile({dart.File dartFile, String dart_file_path}) {
    if (dartFile != null) {
      return this.newFile(this.resolve(dartFile));
    }
    Debug.checkNull("java_file_path", dart_file_path);
    String splitRegex = Pattern.quote(System.getProperty("file.separator"));
    RelativePath splittedFileName = Utils.newRelativePath(path_steps: (dart_file_path.split(splitRegex)));
    File file = this.ROOT().proceed(splittedFileName);
    return file;
  }


  File ApplicationHome() {
    return this.newFile(this.application_home_path_string);
  }

  String application_home_path_string = System.getProperty("user.dir");
}
