library com.jfixby.scarabei.red.io;

import 'dart:io' as dart;

import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_reyer/io/abstract_red_output_stream.dart';
import 'package:scarabei_reyer/io/java_file_output_stream_operator.dart';

abstract class JavaFileOutputStream extends AbstractRedOutputStream<JavaFileOutputStreamOperator> {

  JavaFileOutputStream(dart.File file, bool append) {
    super(new JavaFileOutputStreamOperator(file, append));
  }
}
