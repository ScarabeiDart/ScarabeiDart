library com.jfixby.scarabei.red.filesystem.virtual;

import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file_system.dart';
import 'package:scarabei/api/path/absolute_path.dart';
import 'package:scarabei/red/files/abstract_file_system.dart';
import 'package:scarabei/red/files/virtual/in_memory_file.dart';
import 'package:scarabei/red/files/virtual/in_memory_file_system_content.dart';

class InMemoryFileSystem extends AbstractFileSystem
    implements FileSystem {
  static String OS_SEPARATOR = "/";
  InMemoryFileSystemContent content = new InMemoryFileSystemContent();

  InMemoryFile newFile(AbsolutePath<FileSystem> file_path) {
    if (file_path == null) {
      Err.reportError("Filepath is null.");
    }
    if (file_path.getMountPoint() != this) {
      Err.reportError("Path does not belong to this filesystem: " + file_path.toString());
    }
    return new InMemoryFile(this, file_path);
  }


  String name = "InMemoryFileSystem";

  static String toNativePathString(String string) {
    return string;
  }

  String toString() {
    return this.name;
  }

  InMemoryFileSystemContent getContent() {
    return this.content;
  }

  String getName() {
    return this.name;
  }
}
