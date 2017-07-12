import "dart:io" as dart;

import 'package:scarabei_api/files/file_hash.dart';
import 'package:scarabei_api/files/file_input_stream.dart';
import 'package:scarabei_api/files/file_output_stream.dart';
import 'package:scarabei_api/files/file_system.dart';
import 'package:scarabei_api/files/files_list.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/relative_path.dart';
import 'package:scarabei_api/utils/byte_array.dart';

abstract class File {

  dart.File toJavaFile();

  AbsolutePath<FileSystem> getAbsoluteFilePath();

  bool delete();

  bool isFolder();

  bool isFile();

  void clearFolder();

  FileHash calculateHash();

  FilesList listDirectChildren({bool fileFilter(File file)});

  FilesList listAllChildren({bool fileFilter(File file)});

  File child(String child_name);

  bool exists();

  bool makeFolder();

  bool extensionIs(String postfix);

  String getExtension();

  bool rename(String new_name);

  String getName();

  FileSystem getFileSystem();

  String nameWithoutExtension();

  FileInputStream newInputStream();

  FileOutputStream newOutputStream({bool append});


  String readToString({String encoding});

  ByteArray readBytes();


  void writeBytes({ByteArray array, List<int> bytes, bool append});


  int getSize();

  File parent();


  void writeString(String string, {bool append});

  int lastModified();

  void checkIsFolder();

  void checkExists();

  void checkIsFile();

  File proceed(RelativePath relative);

  FilesList listSubFolders();

  void writeData(Object object);

  File copyTo(String newFileName);

  bool tryToClearFolder();

//
}
