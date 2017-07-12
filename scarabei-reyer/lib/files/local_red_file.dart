library com.jfixby.scarabei.red.filesystem;

import 'dart:io' as dart;

import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/file_system.dart';
import 'package:scarabei_api/files/local_file.dart';
import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/relative_path.dart';
import 'package:scarabei_reyer/files/abstract_red_file.dart';

class LocalRedFile extends AbstractRedFile implements LocalFile {
  AbsolutePath<FileSystem> absolute_path;
  LocalFileSystemComponent fs;

  String getAbsolutePathString(File file) {
    return null;
  }

  dart.File toJavaFile() {
    RelativePath relative = this.getAbsoluteFilePath().getRelativePath();
    java_nio_file_Path path = Paths.get("root").toAbsolutePath().getRoot().toAbsolutePath();
    for (String step in relative.steps()) {
      path = path.resolve(step);
    }
    dart.File f = path.toFile().getAbsoluteFile();
    return f;
  }

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
    dart.File f = this.toJavaFile();
    AbsolutePath<FileSystem> newPath = this.getAbsoluteFilePath().parent().child(new_name);
    File newFile = this.getFileSystem().newFile(newPath);
    bool success = f.renameTo(newFile.toJavaFile());
    if (success) {
      this.absolute_path = newPath;
    }
    return success;
  }

  bool isFile() {
    dart.File f = this.toJavaFile();
    return f.isFile();
  }

  int lastModified() {
    dart.File f = this.toJavaFile();
    return f.lastModified();
  }

  File child(String child_name) {
    return this.getFileSystem().newFile(this.getAbsoluteFilePath().child(child_name));
  }

  String nameWithoutExtension() {
    dart.File file = this.toJavaFile();
    String name = file.getName();
    int dotIndex = name.lastIndexOf('.'.codeUnitAt(0));
    if (dotIndex == (-1)) {
      return name;
    }
    return name.substring(0, dotIndex);
  }

  File parent() {
    if (!this.getAbsoluteFilePath().isRoot()) {
      return this.getFileSystem().newFile(this.getAbsoluteFilePath().parent());
    }
    Err.reportError("This is already a root file. No parent available: " + this);
    return null;
  }

  bool makeFolder() {
    dart.File f = this.toJavaFile();
    return f.mkdirs();
  }

  bool delete() {
    dart.File f = this.toJavaFile();
    if (this.isFolder()) {
      this.clearFolder();
    }
    if (this.getFileSystem().deleteSwitchIsInSafePosition()) {
      L.e("Delete switch is in safe position, file ignored", f);
      return false;
    } else {
      L.d("delete", f);
    }
    return f.delete();
  }

  bool isFolder() {
    dart.File f = this.toJavaFile();
    return f.isDirectory();
  }

  bool exists() {
    dart.File f = this.toJavaFile();
    return f.exists();
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
    while (filesQueue.size() > 0) {
      LocalRedFile nextfile = filesQueue.removeElementAt(0);
      dart.File file = nextfile.toJavaFile();
      if (!file.exists()) {
        Err.reportError("File does not exist: " + file);
      }
      if (file.isDirectory()) {
        List<String> list = file.list();
        if (list == null) {
          L.e("list() is null", file);
          continue;
        }
        List<String> files = Collections.newList(list);
        for (int i = 0; i < files.size(); i++) {
          String file_i = files.getElementAt(i);
          AbsolutePath<FileSystem> absolute_file = nextfile.absolute_path.child(file_i);
          T fs = absolute_file.getMountPoint();
          LocalRedFile child = fs.newFile(absolute_file);
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
    dart.File file = this.toJavaFile();
    if (file.isFile()) {
      return file.length;
    } else {
      return 0;
    }
  }

  String getName() {
    dart.File f = this.toJavaFile();
    return f.getName();
  }
}
