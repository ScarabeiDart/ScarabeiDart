library com.jfixby.scarabei.red.filesystem.virtual;

import "dart:io" as dart;

import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/file_system.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/relative_path.dart';
import 'package:scarabei_reyer/files/abstract_red_file.dart';
import 'package:scarabei_reyer/files/virtual/content_leaf.dart';
import 'package:scarabei_reyer/files/virtual/in_memory_file_system.dart';
import 'package:scarabei_reyer/files/virtual/in_memory_file_system_content.dart';

class InMemoryFile extends AbstractRedFile
    implements File {
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

  dart.File toJavaFile() {
    Err.reportError("The method is not supported");
    return null;
  }

  File parent() {
    return new InMemoryFile(this.virtualFileSystem, this.absolute_path.parent());
  }

  int lastModified() {
    InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
    return content.lastModified(this.absolute_path.getRelativePath());
  }
}
