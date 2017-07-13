import "dart:io" as dart;

import 'package:scarabei_api/files/file_hash.dart';
import 'package:scarabei_api/files/file_system.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/relative_path.dart';

abstract class File {

  dart.FileSystemEntity toDartFile();

  AbsolutePath<FileSystem> getAbsoluteFilePath();

  bool delete();

  bool isFolder();

  bool isFile();

  void clearFolder();

  FileHash calculateHash();

  Iterable<File> listDirectChildren({FileFilter fileFilter = ACCEPT_ALL_FILES});

  Iterable<File> listAllChildren({FileFilter fileFilter = ACCEPT_ALL_FILES});

  File child(String child_name);

  bool exists();

  bool makeFolder();

  bool extensionIs(String postfix);

  String getExtension();

  bool rename(String new_name);

  String getName();

  FileSystem getFileSystem();

  String nameWithoutExtension();

//  Stream<List<int>> newInputStream();
//
//  dart.IOSink newOutputStream({bool append});

  String readString({String encoding});

  void writeString(String string, {bool append});

  List<int> readBytes();

  void writeBytes({List<int> bytes, bool append});

  int getSize();

  File parent();

  int lastModified();

  void checkIsFolder();

  void checkExists();

  void checkIsFile();

  File proceed(RelativePath relative);

  Iterable<File> listSubFolders();

  File copyTo(String newFileName);

  bool tryToClearFolder();


//
}

bool ACCEPT_ALL_FILES(File file) {
  return true;
}

typedef bool FileFilter(File file);


