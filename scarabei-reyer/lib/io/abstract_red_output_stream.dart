library com.jfixby.scarabei.red.io;

import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/debug/state_switcher.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file_output_stream.dart';
import 'package:scarabei_api/io/java_output_stream_operator.dart';
import 'package:scarabei_api/io/stream_state.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/utils/byte_array.dart';
import 'package:scarabei_api/utils/jutils.dart';

class AbstractRedOutputStream<T extends JavaOutputStreamOperator> implements FileOutputStream {
  StateSwitcher<STREAM_STATE> state;
  T operator;
  Exception source;

  AbstractRedOutputStream(T operator) {
    this.operator = operator;
    this.state = Debug.newStateSwitcher(STREAM_STATE.CLOSED);
    if (SystemSettings.executionModeCovers(ExecutionMode.EARLY_DEVELOPMENT)) {
      this.source = new Exception();
    }
  }

  T getOperator() {
    return this.operator;
  }

  DartOutputStream javaStream() {
    return this.operator.getJavaStream();
  }

  void write(Data data) {
    this.state.expectState(STREAM_STATE.OPEN);
    RedData di = data;
    this.javaStream().write(di.integer);
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

  void flush() {
    this.state.expectState(STREAM_STATE.OPEN);
    this.javaStream().flush();
  }

  void write(ByteArray bytes) {
    this.state.expectState(STREAM_STATE.OPEN);
    JavaOutputStreamOperator op = this.operator;
    if (op.isBulkWriteSupported()) {
      op.writeAll(bytes);
      return;
    }
    this.javaStream().write(bytes.toArray());
    this.javaStream().flush();
  }

  OutputStream toJavaOutputStream() {
    this.state.expectState(STREAM_STATE.OPEN);
    return this.javaStream();
  }

  void write(List<int> bytes) {
    this.state.expectState(STREAM_STATE.OPEN);
    this.write(Utils.newByteArray(bytes));
  }

  STREAM_STATE getState() {
    return this.state.currentState();
  }

  void finalize() {
    super.finalize();
    if (this.state.currentState() != STREAM_STATE.CLOSED) {
      String msg = ((("Stream leak detected: " + this.toString()) + " state=") + this.state.toString());
      L.e(msg);
      if (SystemSettings.executionModeCovers(ExecutionMode.EARLY_DEVELOPMENT)) {
        Err.reportError(new Error(msg, this.source));
      }
      this.close();
    }
  }

  bool isOpen() {
    return this.getState() == STREAM_STATE.OPEN;
  }

  bool isClosed() {
    return this.getState() == STREAM_STATE.CLOSED;
  }
}
