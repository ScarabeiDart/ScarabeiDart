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
import 'package:scarabei_reyer/files/red_local_file_system.dart';

class LocalRedFile extends AbstractRedFile implements LocalFile {
  AbsolutePath<FileSystem> absolute_path;
  RedLocalFileSystem fs;


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
//    if (this.absolute_path.isRoot()) {
//      return false;
//    }
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
    return this.fs.dartFilePath(this.absolute_path);
  }

  bool isFile() {
//    if (this.absolute_path.isRoot()) {
//      return false;
//    }
    return new dart.File(dartFilePath()).existsSync();
  }

  bool isFolder() {
//    if (this.absolute_path.isRoot()) {
//      return true;
//    }
    return new dart.Directory(dartFilePath()).existsSync();
  }

  bool exists() {
//    if (this.absolute_path.isRoot()) {
//      return true;
//    }
    return new dart.File(dartFilePath()).existsSync() || new dart.Directory(dartFilePath()).existsSync();
  }


  int lastModified() {
//    if (this.absolute_path.isRoot()) {
//      return 0;
//    }
//    return new dart.File(dartFilePath()).existsSync() || new dart.Directory(dartFilePath()).existsSync();
//    dart.File f = this.toJavaFile();
    return new dart.File(dartFilePath())
        .lastModifiedSync()
        .millisecondsSinceEpoch;
  }

  File child(String child_name) {
    AbsolutePath<FileSystem> me = this.getAbsoluteFilePath();
//    L.d("steps", me.getRelativePath().steps());
//    var rp = Utils.newRelativePath(relative_path_string: "");
//    L.d("   rp", rp.steps());
    AbsolutePath<FileSystem> child = me.child(child_name);
    return this.getFileSystem().newFile(child);
  }


  File parent() {
    if (!this.getAbsoluteFilePath().isRoot()) {
      return this.getFileSystem().newFile(this.getAbsoluteFilePath().parent());
    }
    Err.reportError("This is already a root file. No parent available: " + this.toString());
    return null;
  }

  bool makeFolder() {
//    if (this.absolute_path.isRoot()) {
//      return true;
//    }
//    dart.File f = this.toJavaFile();
//    new dart.Directory(f.path)
//    return f.mkdirs();
    new dart.Directory(dartFilePath()).createSync(recursive: true);
    return true;
  }

  bool delete() {
//    if (this.absolute_path.isRoot()) {
//      return false;
//    }
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


  int getSize() {
    if (this.isFolder()) {
//      dart.FileSystemException e;
      return 0;
    } else if (this.isFile()) {
      new dart.File(dartFilePath()).lengthSync();
    }
  }

  String getName() {
//    if (this.absolute_path.isRoot()) {
//      return "";
//    }
//    dart.File f = this.toJavaFile();
    return path.basename(this.dartFilePath());
  }

  @override
  dart.FileSystemEntity toDartFile() {
//    if (this.absolute_path.isRoot()) {
//      return null;
//    }
    var pathString = this.absolute_path.getRelativePath().toString();
    var file = new dart.File(pathString).absolute;
    return file;
  }

  static bool DIRECT_CHILDREN = true;
  static bool ALL_CHILDREN = (!DIRECT_CHILDREN);

  Iterable<File> listDirectChildren({bool fileFilter(File file)}) {
    if (fileFilter == null) {
      fileFilter = (x) => true;
    }
    List<LocalRedFile> filesQueue = [];
    filesQueue.add(this);
    List<File> result = new List<File>();
    collectChildren(filesQueue, result, DIRECT_CHILDREN, fileFilter);
    return result;
  }

  Iterable<File> listAllChildren({bool fileFilter(File file)}) {
    if (fileFilter == null) {
      fileFilter = (x) => true;
    }
    List<LocalRedFile> filesQueue = [];
    filesQueue.add(this);
    List<File> result = new List<File>();
    collectChildren(filesQueue, result, ALL_CHILDREN, fileFilter);
    return result;
  }

  static void collectChildren(List<LocalRedFile> filesQueue, List<File> result, bool directFlag, bool fileFilter(File file)) {
    while (filesQueue.length > 0) {
      LocalRedFile nextfile = filesQueue.removeAt(0);
//      dart.File file = nextfile.toJavaFile();
      if (!nextfile.exists()) {
        if (nextfile.getAbsoluteFilePath().isRoot()) {
          L.e("Seems like you are calling the root in Windows OS and this functionallity is not yet implemented.");
          String rootPrefix = path.rootPrefix(new dart.File("").absolute.path);
          nextfile = nextfile.fs.newLocalFile(new dart.File(rootPrefix));
          L.e("to save you for now redirecting root to", nextfile);
          L.e("It is just a warning but you better be careful next time.");
        } else {
          Err.reportError("File does not exist: " + nextfile.toString() + " " + nextfile.dartFilePath());
        }
//        Err.reportError("File does not exist: " + nextfile.toString() + " " + nextfile.dartFilePath() + " Seems like you are calling root in Windows OS and this functionallity is not yet implemented.");
      }
//      if (nextfile.absolute_path.isRoot()) {
////        sdfd
//      } else
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
          if (fileFilter(child)) {
            result.add(child);
            if (directFlag == ALL_CHILDREN) {
              if (child.isFolder()) {
                filesQueue.add(child);
              }
            } else {}
          }
        }
      } else {
        Err.reportError("This is not a folder: " + nextfile.absolute_path.toString());
      }
    }
  }
}
