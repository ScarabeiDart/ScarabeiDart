library com.jfixby.scarabei.red.filesystem;

import 'dart:io' as dart;

import 'package:path/path.dart' as path;
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/file_system.dart';
import 'package:scarabei_api/files/local_file.dart';
import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_reyer/files/abstract_red_file.dart';

class LocalRedFile extends AbstractRedFile implements LocalFile {
  AbsolutePath<FileSystem> absolute_path;
  LocalFileSystemComponent fs;

  String getAbsolutePathString(File file) {
    return null;
  }

//  dart.File toJavaFile() {
//    RelativePath relative = this.getAbsoluteFilePath().getRelativePath();
//    java_nio_file_Path path = Paths.get("root").toAbsolutePath().getRoot().toAbsolutePath();
//    for (String step in relative.steps()) {
//      path = path.resolve(step);
//    }
//    dart.File f = path.toFile().getAbsoluteFile();
//    return f;
//  }

  LocalRedFile(AbsolutePath<FileSystem> absolute_path, LocalFileSystemComponent fileSystem) {
    this.absolute_path = absolute_path;
    this.fs = fileSystem;
  }

  LocalFileSystemComponent getFileSystem() {
    return this.fs;
  }

  AbsolutePath<FileSystem> getAbsoluteFilePath() {
    return this.absolute_path;
  }

  bool rename(String new_name) {
    dart.FileSystemEntity e = this.toDartFile();

    File newFile = this.parent().child(new_name);

    String newDartPath = newFile
        .toDartFile()
        .path;

    e.renameSync(newDartPath);

    this.absolute_path = newFile.getAbsoluteFilePath();

    return true;
  }

  String dartFilePath() {
    Err.throwNotImplementedYet();
    return null;
  }

  bool isFile() {
    return new dart.File(dartFilePath()).existsSync();
  }

  bool isFolder() {
    return new dart.Directory(dartFilePath()).existsSync();
  }

  bool exists() {
    return new dart.File(dartFilePath()).existsSync() || new dart.Directory(dartFilePath()).existsSync();
  }


  int lastModified() {
//    return new dart.File(dartFilePath()).existsSync() || new dart.Directory(dartFilePath()).existsSync();
//    dart.File f = this.toJavaFile();
    return new dart.File(dartFilePath())
        .lastModifiedSync()
        .millisecondsSinceEpoch;
  }

  File child(String child_name) {
    return this.getFileSystem().newFile(this.getAbsoluteFilePath().child(child_name));
  }


  File parent() {
    if (!this.getAbsoluteFilePath().isRoot()) {
      return this.getFileSystem().newFile(this.getAbsoluteFilePath().parent());
    }
    Err.reportError("This is already a root file. No parent available: " + this.toString());
    return null;
  }

  bool makeFolder() {
//    dart.File f = this.toJavaFile();
//    new dart.Directory(f.path)
//    return f.mkdirs();
    new dart.Directory(dartFilePath()).createSync(recursive: true);
    return true;
  }

  bool delete() {
    if (this.isFolder()) {
      this.clearFolder();
    }
    if (this.getFileSystem().deleteSwitchIsInSafePosition()) {
      L.e("Delete switch is in safe position, file ignored", dartFilePath());
      return false;
    } else {
      L.d("delete", dartFilePath());
    }
    if (this.isFolder()) {
      new dart.Directory(dartFilePath()).deleteSync(recursive: true);
    } else if (this.isFile()) {
      new dart.File(dartFilePath()).deleteSync(recursive: true);
    }
    return true;
  }


  static bool DIRECT_CHILDREN = true;
  static bool ALL_CHILDREN = (!DIRECT_CHILDREN);

  Iterable<File> listDirectChildren({bool fileFilter(File file)}) {
    List<LocalRedFile> filesQueue = [];
    filesQueue.add(this);
    List<File> result = new List<File>();
    collectChildren(filesQueue, result, DIRECT_CHILDREN);
    return result;
  }

  Iterable<File> listAllChildren({bool fileFilter(File file)}) {
    List<LocalRedFile> filesQueue = [];
    filesQueue.add(this);
    List<File> result = new List<File>();
    collectChildren(filesQueue, result, ALL_CHILDREN);
    return result;
  }

  static void collectChildren(List<LocalRedFile> filesQueue, List<File> result, bool directFlag) {
    while (filesQueue.length > 0) {
      LocalRedFile nextfile = filesQueue.removeAt(0);
//      dart.File file = nextfile.toJavaFile();
      if (!nextfile.exists()) {
        Err.reportError("File does not exist: " + nextfile.toString());
      }
      if (nextfile.isFolder()) {
//        for (var fileOrDir in contents) {
//          if (fileOrDir is dart.File) {
//            print(fileOrDir.name);
//          } else if (fileOrDir is Directory) {
//            print(fileOrDir.path);
//          }
//        }
//
//        List<String> list = file.list();
//        if (list == null) {
//          L.e("list() is null", file);
//          continue;
//        }
        var dir = new dart.Directory(nextfile.dartFilePath());
        List<dart.FileSystemEntity> contents = dir.listSync();
        for (int i = 0; i < contents.length; i++) {
          dart.FileSystemEntity entry = contents[i];
          String file_i = path.basename(entry.absolute.path);
          LocalRedFile child = nextfile.child(file_i);
          result.add(child);
          if (directFlag == ALL_CHILDREN) {
            if (child.isFolder()) {
              filesQueue.add(child);
            }
          } else {}
        }
      } else {
        Err.reportError("This is not a folder: " + nextfile.absolute_path.toString());
      }
    }
  }

  int getSize() {
    if (this.isFolder()) {
//      dart.FileSystemException e;
      return 0;
    } else if (this.isFile()) {
      new dart.File(dartFilePath()).lengthSync();
    }
  }

  String getName() {
//    dart.File f = this.toJavaFile();
    return path.basename(this.dartFilePath());
  }

  @override
  dart.FileSystemEntity toDartFile() {
    var pathString = this.absolute_path.getRelativePath().toString();
    var file = new dart.File(pathString).absolute;
    return file;
  }
}
