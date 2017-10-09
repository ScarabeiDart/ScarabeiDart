import 'package:scarabei/api/files/file.dart';

abstract class FilesList {
  FilesList filter(FileFilter fileFilter);

  Iterable<File> toList();

  void deleteAll();
}
