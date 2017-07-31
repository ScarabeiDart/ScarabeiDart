library com.jfixby.scarabei.red.filesystem;

import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/files/file_hash.dart';
import 'package:scarabei/api/files/file_system.dart';
import 'package:scarabei/api/io/io_exception.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/path/absolute_path.dart';
import 'package:scarabei/api/path/relative_path.dart';
import 'package:scarabei_reyer/red/files/abstract_file_system.dart';


abstract class AbstractRedFile implements File {

  void clearFolder() {
    if (this.isFolder()) {
      Iterable<File> children = this.listDirectChildren();
      for (int i = 0; i < children.length; i++) {
        File child = children.elementAt(i);
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
      throw new IOException(this.toString() + " does not exist.");
    }
  }

  void checkIsFile() {
    this.checkExists();
    if (!this.isFile()) {
      throw new IOException(this.toString() + " does not exist.");
    }
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

  List<File> listSubFolders() {
    List<File> listFiles = [];
    Iterable<File> children = this.listDirectChildren();
    for (File file in children) {
      if (file.isFolder()) {
        listFiles.add(file);
      }
    }
    return listFiles;
  }


//  List<int> readBytes() {
//    FileInputStream is_ = this.getFileSystem().newFileInputStream(this);
//    ByteArray bytes;
//    is_.open();
//    try {
//      bytes = is_.readAll();
//      return bytes;
//    } on IOException catch (e) {
//      throw e;
//    } finally {
//      is_.close();
//    }
//  }
//
//
//  void writeBytes({List<int> bytes, bool append}) {
//    FileOutputStream os = this.getFileSystem().newFileOutputStream(this, append: append);
//    os.open();
//    try {
//      if (array != null) {
//        os.write(array: array);
//      } else {
//        os.write(bytes: bytes);
//      }
//    } on IOException catch (e) {
//      throw e;
//    } finally {
//      os.close();
//    }
//  }


  String nameWithoutExtension() {
    String name = this.getName();
    int dotIndex = name.lastIndexOf('.');
    if (dotIndex == (-1)) {
      return name;
    }
    return name.substring(0, dotIndex);
  }

//  void writeString(String string, {bool append}) {
//    this.writeBytes(bytes: Strings.toBytes(string), append: append);
//  }
//
//  String readString({String encoding = "utf8"}) {
//    return Strings.newString(bytes: this.readBytes(), encoding: encoding);
//  }

//  @override
//  void writeBytes({List<int> bytes, bool append = false}) {
//    dart.IOSink stream = this.newOutputStream(append: append);
//    stream.add(bytes);
//    stream.flush();
//    stream.close();
//  }

//  @override
//  List<int> readBytes() {
////    Stream<List<int>> inputStream = newInputStream();
////    List<int> result = [];
////
////    var onData = (List<int> event) {
////      L.d("read", event);
////      result.addAll(event);
////      L.d("result add", event);
////    };
////
////    Function onError = (e) {
////      throw e;
//////      Err.reportError("", e);
////    };
////
////    var onDone = () {};
////
////    inputStream
//////        .transform(UTF8.decoder) // Decode bytes to UTF8.
//////        .transform(new LineSplitter()) // Convert stream to individual lines.
////        .listen(onData,
////        onError: onError,
////        onDone: onDone, cancelOnError: true);
////
////    L.d("result", result);
////    return result;
//
//    var completer = new Completer<List<int>>();
//
//    var inputStream = newInputStream();
//    var result = <int>[];
//
//    var onData = (List<int> event) {
//      result.addAll(event);
//    };
//
//    Function onError = (e) {
//      completer.completeError(e);
//    };
//
//    var onDone = () {
//      completer.complete(result);
//    };
//
//    inputStream
//        .listen(onData,
//        onError: onError,
//        onDone: onDone, cancelOnError: true);
//
//    while (!completer.isCompleted) {
//      dart.sleep();
//    }
//
//    return completer.future;
//  }

//  Stream<List<int>> newInputStream() {
//    return this.getAbsoluteFilePath().getMountPoint().newInputStream(this.getAbsoluteFilePath());
//  }
//
//  dart.IOSink newOutputStream({bool append = false}) {
//    return this.getAbsoluteFilePath().getMountPoint().newOutputStream(this.getAbsoluteFilePath());
//  }


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

//  FileInputStream newInputStream() {
//    return this.getFileSystem().newFileInputStream(this);
//  }
//
//
//  FileOutputStream newOutputStream({bool append}) {
//    return this.getFileSystem().newFileOutputStream(this, append: append);
//  }

  String getExtension() {
    if (this.isFolder()) {
      return "";
    }
    String name = this.getName().toLowerCase();
    int index = name.lastIndexOf('.');
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

//  Iterable<File> listDirectChildren({bool fileFilter(File file)}) {
//    return this.listDirectChildren().where(fileFilter).toList();
//  }
//
//  Iterable<File> listAllChildren({bool fileFilter(File file)}) {
//    return this.listAllChildren().where(fileFilter).toList();
//  }

  bool tryToClearFolder() {
    try {
      this.clearFolder();
      return true;
    } on IOException catch (e) {
      L.e(e);
      return false;
    }
  }

  Iterable<File> listAllChildren({FileFilter fileFilter = ACCEPT_ALL_FILES}) {
    List<File> filesQueue = [];
    filesQueue.add(this);
    Set<File> result = new Set<File>();
    collectChildren(filesQueue, result, false, fileFilter);
    return result;
  }

  static bool DIRECT_CHILDREN = true;
  static bool ALL_CHILDREN = (!DIRECT_CHILDREN);

  static void collectChildren(List<File> filesQueue, Set<File> result, bool directFlag, FileFilter fileFilter) {
    while (filesQueue.length > 0) {
      File nextfile = filesQueue.removeAt(0);

      if (nextfile.isFolder()) {
        Iterable<File> files = nextfile.listDirectChildren();
        for (int i = 0; i < files.length; i++) {
          File child = files.elementAt(i);
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
        Err.reportError("This is not a folder: " + nextfile.getAbsoluteFilePath().toString());
      }
    }
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AbstractRedFile &&
              runtimeType == other.runtimeType &&
              this.getAbsoluteFilePath() == other.getAbsoluteFilePath();

  @override
  int get hashCode => getAbsoluteFilePath().hashCode;


}
