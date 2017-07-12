library com.jfixby.scarabei.red.filesystem;

import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/file_hash.dart';
import 'package:scarabei_api/files/file_input_stream.dart';
import 'package:scarabei_api/files/file_output_stream.dart';
import 'package:scarabei_api/files/file_system.dart';
import 'package:scarabei_api/files/files_list.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/relative_path.dart';
import 'package:scarabei_api/strings/strings.dart';
import 'package:scarabei_api/utils/byte_array.dart';
import 'package:scarabei_reyer/files/abstract_file_system.dart';
import 'package:scarabei_reyer/files/red_files_list.dart';


abstract class AbstractRedFile extends File {

  void clearFolder() {
    if (this.isFolder()) {
      FilesList children = this.listDirectChildren();
      for (int i = 0; i < children.size(); i++) {
        File child = children.getElementAt(i);
        child.delete();
      }
    } else {
      L.e("Unable to clear", this.getAbsoluteFilePath());
      L.e("       this is not a folder.");
    }
  }

//  int hashCode() {
//    return this.getAbsoluteFilePath().hashCode();
//  }
//
//  bool ==(Object obj) {
//    if (this == obj) {
//      return true;
//    }
//    if (obj == null) {
//      return false;
//    }
//    if (this.getClass() != obj.getClass()) {
//      return false;
//    }
//    AbstractRedFile other = obj;
//    return this.getAbsoluteFilePath() == other.getAbsoluteFilePath();
//  }

  void checkIsFolder() {
    this.checkExists();
    if (!this.isFolder()) {
      throw new IOException(("" + this.toString()) + " is not a folder");
    }
  }

  void checkExists() {
    if (!this.exists()) {
      throw new IOException(this + " does not exist.");
    }
  }

  void checkIsFile() {
    this.checkExists();
    if (!this.isFile()) {
      throw new IOException(this + " does not exist.");
    }
  }

  void writeData(Object object) {
    ByteArray data = IO.serialize(object);
    this.writeBytes(data);
  }

  File proceed(RelativePath relativePath) {
    AbsolutePath<FileSystem> file_path = this.getAbsoluteFilePath().proceed(relativePath);
    return this.getFileSystem().newFile(file_path);
  }

  bool extensionIs(String postfix) {
    String name = this.getName().toLowerCase();
    bool result = name.endsWith("." + postfix.toLowerCase());
    return result;
  }

  FilesList listSubFolders() {
    RedFilesList listFiles = new RedFilesList();
    FilesList children = this.listDirectChildren();
    for (File file in children) {
      if (file.isFolder()) {
        listFiles.add(file);
      }
    }
    return listFiles;
  }


  String readToString({String encoding}) {
    return Strings.newString(byteArray: this.readBytes(), encoding: encoding);
  }

  ByteArray readBytes() {
    FileInputStream is_ = this.getFileSystem().newFileInputStream(this);
    ByteArray bytes;
    is_.open();
    try {
      bytes = is_.readAll();
      return bytes;
    } on IOException catch (e) {
      throw e;
    } finally {
      is_.close();
    }
  }


  void writeBytes({ByteArray array, List<int> bytes, bool append}) {
    FileOutputStream os = this.getFileSystem().newFileOutputStream(this, append: append);
    os.open();
    try {
      if (array != null) {
        os.write(array: array);
      } else {
        os.write(bytes: bytes);
      }
    } on IOException catch (e) {
      throw e;
    } finally {
      os.close();
    }
  }


  void writeString(String string, {bool append}) {
    this.writeBytes(bytes: Strings.toBytes(string), append: append);
  }

  String toString() {
    return this.getAbsoluteFilePath().toString();
  }

//  T readData(Class type) {
//    ByteArray bytes = this.readBytes();
//    return IO.deserialize(type, bytes);
//  }

  FileHash calculateHash() {
    return this.getAbstractFileSystem().md5Hex(this);
  }

  AbstractFileSystem getAbstractFileSystem() {
    return this.getFileSystem();
  }

  FileInputStream newInputStream() {
    return this.getFileSystem().newFileInputStream(this);
  }


  FileOutputStream newOutputStream({bool append}) {
    return this.getFileSystem().newFileOutputStream(this, append: append);
  }

  String getExtension() {
    if (this.isFolder()) {
      return "";
    }
    String name = this.getName().toLowerCase();
    int index = name.lastIndexOf('.'.codeUnitAt(0));
    if (index < 0) {
      return "";
    }
    String ext = name.substring(index + 1);
    return ext;
  }

  File copyTo(String newFileName) {
    File outputFile = this.parent().child(Debug.checkNull(newFileName, "newFileName"));
    this.getFileSystem().copyFileToFile(this, outputFile);
    return outputFile;
  }

  FilesList listDirectChildren({bool fileFilter(File file)}) {
    return this.listDirectChildren().filter(fileFilter);
  }

  FilesList listAllChildren({bool fileFilter(File file)}) {
    return this.listAllChildren().filter(fileFilter);
  }

  bool tryToClearFolder() {
    try {
      this.clearFolder();
      return true;
    } on IOException catch (e) {
      L.e(e);
      return false;
    }
  }

//  FilesList listAllChildren({bool fileFilter(File file)}) {
//    List<File> filesQueue = [];
//    filesQueue.add(this);
//    RedFilesList result = new RedFilesList();
//    collectChildren(filesQueue, result, false);
//    return result;
//  }

  static bool DIRECT_CHILDREN = true;
  static bool ALL_CHILDREN = (!DIRECT_CHILDREN);

  static void collectChildren(List<File> filesQueue, RedFilesList result, bool directFlag) {
    while (filesQueue.length > 0) {
      File nextfile = filesQueue.removeAt(0);
      if (nextfile.isFolder()) {
        FilesList files = nextfile.listDirectChildren();
        for (int i = 0; i < files.size(); i++) {
          File child = files.getElementAt(i);
          result.add(child);
          if (directFlag == ALL_CHILDREN) {
            if (child.isFolder()) {
              filesQueue.add(child);
            }
          } else {}
        }
      } else {
        Err.reportError("This is not a folder: " + nextfile.getAbsoluteFilePath().toString());
      }
    }
  }
}
