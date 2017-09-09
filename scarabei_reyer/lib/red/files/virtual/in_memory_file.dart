
import "dart:io" as dart;

import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/files/file_system.dart';
import 'package:scarabei/api/files/files_list.dart';
import 'package:scarabei/api/io/io_exception.dart';
import 'package:scarabei/api/path/absolute_path.dart';
import 'package:scarabei/api/path/relative_path.dart';
import 'package:scarabei/api/strings/strings.dart';
import 'package:scarabei/api/sys/sys.dart';
import 'package:scarabei_reyer/red/files/abstract_red_file.dart';
import 'package:scarabei_reyer/red/files/reyer_files_list.dart';
import 'package:scarabei_reyer/red/files/virtual/content_leaf.dart';
import 'package:scarabei_reyer/red/files/virtual/in_memory_file_system.dart';
import 'package:scarabei_reyer/red/files/virtual/in_memory_file_system_content.dart';

class InMemoryFile extends AbstractRedFile implements File {
  InMemoryFileSystem virtualFileSystem;
  AbsolutePath<FileSystem> absolute_path;
  RelativePath relativePath;

  InMemoryFile(InMemoryFileSystem virtualFileSystem, AbsolutePath<FileSystem> file_path) {
    this.virtualFileSystem = virtualFileSystem;
    this.absolute_path = file_path;
    this.relativePath = file_path.getRelativePath();
  }

  AbsolutePath<FileSystem> getAbsoluteFilePath() {
    return this.absolute_path;
  }

  bool delete() {
    if (this.isFolder()) {
      this.clearFolder();
    }
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    return content.delete(this.absolute_path.getRelativePath());
  }

  bool isFolder() {
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    return content.isFolder(this.absolute_path.getRelativePath());
  }

  bool isFile() {
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    return content.isFile(this.absolute_path.getRelativePath());
  }

  File child(String child_name) {
    return new InMemoryFile(this.getFileSystem(), this.absolute_path.child(child_name));
  }

  bool exists() {
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    return content.exists(this.absolute_path.getRelativePath());
  }

  bool makeFolder() {
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    return content.mkdirs(this.absolute_path.getRelativePath());
  }

  bool rename(String new_name) {
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    content.rename(this.absolute_path.getRelativePath(), new_name);
    this.absolute_path = this.absolute_path.parent().child(new_name);
    this.relativePath = this.absolute_path.getRelativePath();
    return true;
  }

  String getName() {
    if (this.relativePath.isRoot()) {
      return this.virtualFileSystem.getName();
    }
    return this.absolute_path.getName();
  }

  InMemoryFileSystem getFileSystem() {
    return this.virtualFileSystem;
  }

  ContentLeaf createFile() {
    if (this.relativePath.isRoot()) {
      return null;
    }
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    if (!content.mkdirs(this.relativePath.parent())) {
      return null;
    }
    return content.createFile(this.relativePath);
  }

  ContentLeaf getContent() {
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    return content.getContentLeaf(this.relativePath);
  }

  int getSize() {
    if (this.isFile()) {
      return this.getContent().size();
    } else {
      return 0;
    }
  }

  File parent() {
    return new InMemoryFile(this.virtualFileSystem, this.absolute_path.parent());
  }

  int lastModified() {
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    return content.lastModified(this.absolute_path.getRelativePath());
  }

  @override
  dart.FileSystemEntity toDartFile() {
    Err.reportError("Operation is not supported");
    return null;
  }

  @override
  List<int> readBytes() {
    ContentLeaf contentLeaf = this.getContent();
    if (contentLeaf == null) {
      throw new IOException("File not found " + this.toString());
    }
    return contentLeaf.data.toList();
  }

  @override
  String readString({String encoding}) {
    return Strings.newString(bytes: this.readBytes());
  }

  @override
  void writeBytes({List<int> bytes, bool append = false}) {
    var leaf = this.getContent();
    if (leaf == null) {
      leaf = createFile();
      if (leaf == null) {
        throw new IOException("Unable to write to the file: " + this.toString());
      }
    }
    if (append) {
      leaf.data = bytes.toList();
    } else {
      leaf.data.addAll(bytes);
    }
    leaf.last_edit = Sys.currentTime();
  }

  @override
  void writeString(String string, {bool append}) {
    this.writeBytes(bytes: Strings.toBytes(string), append: append);
  }

//
//  bool _default(int value) {
//    return true;
//  }
//
//  num myFunc({someTest: _default}) {
//    return 15;
//  }

  @override
  FilesList listDirectChildren({FileFilter fileFilter = ACCEPT_ALL_FILES}) {
    fileFilter ??= ACCEPT_ALL_FILES;
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    if (!content.exists(this.relativePath)) {
      Err.reportError("File does not exist: " + this.absolute_path.toString());
    }
    if (content.isFolder(this.relativePath)) {
      List<String> files = content.listChildren(this.relativePath);
      Set<File> listFiles = new Set<File>();
      for (int i = 0; i < files.length; i++) {
        String file_i = files.elementAt(i);
        AbsolutePath<FileSystem> absolute_file = this.absolute_path.child(file_i);
        File f = absolute_file.getMountPoint().newFile(absolute_file);
        if (fileFilter(f)) {
          listFiles.add(f);
        }
      }
      return new ReyerFilesList(listFiles);
    } else {
      Err.reportError("This is not a folder: " + this.absolute_path.toString());
    }
    return null;
  }
}
