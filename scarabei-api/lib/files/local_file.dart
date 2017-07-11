import "dart:io" as dart;

import 'package:scarabei_api/files/file.dart';

abstract class LocalFile extends File {

  dart.File toJavaFile();
}
