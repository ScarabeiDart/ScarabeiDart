library com.jfixby.scarabei.red.io;

import 'dart:async';
import 'dart:io' as dart;
import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/debug/state_switcher.dart';
import 'package:scarabei_api/io/input_stream.dart';
import 'package:scarabei_api/io/java_input_stream_operator.dart';
import 'package:scarabei_api/io/stream_state.dart';
import 'package:scarabei_api/strings/strings.dart';
import 'package:scarabei_api/utils/byte_array.dart';
import 'package:scarabei_api/utils/jutils.dart';

abstract class AbstractRedInputStream<T extends JavaInputStreamOperator> extends InputStream {
  StateSwitcher<STREAM_STATE> state;
  T operator;
  Exception source;

  T getOperator() {
    return this.operator;
  }

  STREAM_STATE getState() {
    return this.state.currentState();
  }

  void open() {
    this.state.expectState(STREAM_STATE.CLOSED);
    this.state.switchState(STREAM_STATE.OPEN);
  }

  void close() {
    this.state.expectState(STREAM_STATE.OPEN);
    this.state.switchState(STREAM_STATE.CLOSED);
    try {
      this.operator.closeStream();
    } on Throwable catch (e) {}
  }

  AbstractRedInputStream(T operator) {
    this.operator = operator;
    this.state = Debug.newStateSwitcher(STREAM_STATE.CLOSED);
    this.state.setDebugName(this.toString());
    if (SystemSettings.executionModeCovers(ExecutionMode.EARLY_DEVELOPMENT)) {
      this.source = new Exception();
    }
  }

  bool hasData() {
    this.state.expectState(STREAM_STATE.OPEN);
    if (this.javaStream().available() > 0) {
      return true;
    }
    return false;
  }


  int read() {
    this.state.expectState(STREAM_STATE.OPEN);

    dart.File script = new dart.File(Platform.script.toFilePath());
    dart.RandomAccessFile file = await
    script.open(mode: dart.FileMode.READ);
    file.readByte()

    return this
        .javaStream()
        .read()
        .readByte
    .
  }

  InputStream javaStream() {
    this.state.expectState(STREAM_STATE.OPEN);
    return this.operator.getJavaStream();
  }

  int available() {
    this.state.expectState(STREAM_STATE.OPEN);
    return this.javaStream().available();
  }

  ByteArray readAll() {
    this.state.expectState(STREAM_STATE.OPEN);
    JavaInputStreamOperator op = this.operator;
    if (op.isReadAllSupported()) {
      return op.readAll();
    }
    java_io_ByteArrayOutputStream baos = new java_io_ByteArrayOutputStream();
    List<int> buf = new List<int>((10 * 4096));
    while (true) {
      int n = this.javaStream().read(buf);
      if (n < 0) {
        break;
      }
      baos.write(buf, 0, n);
    }
    List<int> data = baos.toByteArray();
    return JUtils.newByteArray(data);
  }

  java.io.InputStream toJavaInputStream() {
    this.state.expectState(STREAM_STATE.OPEN);
    return this.javaStream();
  }

  void finalize() {
    super.finalize();
    if (this.state.currentState() != STREAM_STATE.CLOSED) {
      String msg = ((("Stream leak detected: " + this) + " state=") + this.state);
      System.err.println(msg);
      Err.reportGCLeak(msg, this);
      this.close();
    }
  }

  bool isOpen() {
    return this.getState() == STREAM_STATE.OPEN;
  }

  bool isClosed() {
    return this.getState() == STREAM_STATE.CLOSED;
  }

  String readAllToString({String encoding}) {
    Debug.checkNull(encoding, "encoding");
    Debug.checkEmpty(encoding, "encoding");
    ByteArray bytes = this.readAll();
    return Strings.newString(byteArray: bytes, encoding: encoding);
  }
}
