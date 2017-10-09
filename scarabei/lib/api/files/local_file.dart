import 'package:scarabei/api/files/file.dart';
import "dart:io" as dart;

abstract class LocalFile extends File {
  dart.FileSystemEntity toDartFile();
}
