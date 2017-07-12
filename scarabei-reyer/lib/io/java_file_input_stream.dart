library com.jfixby.scarabei.red.io;

import 'dart:io' as dart;
import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/file_input_stream.dart';
import 'package:scarabei_reyer/io/abstract_red_input_stream.dart';
import 'package:scarabei_reyer/io/java_file_input_stream_operator.dart';

class JavaFileInputStream extends AbstractRedInputStream<JavaFileInputStreamOperator>
    implements FileInputStream {
  dart.File file;

  JavaFileInputStream(dart.File file) {
    super(new JavaFileInputStreamOperator(file));
    this.file = file;
  }

  String toString() {
    return ("JavaFileInputStream=" + this.file.toString()) + "";
  }

  int getFileSize() {
    return this.file.getSize();
  }
}
