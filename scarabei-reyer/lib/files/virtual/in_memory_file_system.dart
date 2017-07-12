library com.jfixby.scarabei.red.filesystem.virtual;

import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file_system.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_reyer/files/abstract_file_system.dart';
import 'package:scarabei_reyer/files/virtual/in_memory_file.dart';
import 'package:scarabei_reyer/files/virtual/in_memory_file_system_content.dart';

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

//  FileOutputStream newFileOutputStream(File output_file, bool append) {
//    if (output_file == null) {
//      Err.reportError("Output file is null.");
//    }
//    if (output_file.getFileSystem() != this) {
//      Err.reportError("Output file does not belong to this filesystem: " + output_file);
//    }
//    return new InMemoryFileOutputStream(output_file, append);
//  }
//
//  FileInputStream newFileInputStream(File input_file) {
//    if (input_file == null) {
//      Err.reportError("Input file is null.");
//    }
//    if (input_file.getFileSystem() != this) {
//      Err.reportError("Input file does not belong to this filesystem: " + input_file);
//    }
//    return new InMemoryFileInputStream(input_file);
//  }

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
