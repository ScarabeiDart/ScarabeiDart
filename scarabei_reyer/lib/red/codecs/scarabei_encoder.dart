import 'package:scarabei/api/codec/from_dart_encoder.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';
import 'package:scarabei/api/codec/scarabei_class_names.dart';

class ScarabeiEncoder implements FromDartEncoder {
  bool canEncode(Object flutterObject) {
    if (flutterObject == null) {
      return true;
    }
    if (flutterObject is ExecutionMode) {
      return true;
    }
    if (flutterObject is ID) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> encodeID(ID value) => EncodedObject.encodeObject(value: value.toString(), type: ScarabeiClassNames.ID_TYPE_STRING);

  Map<String, dynamic> encodeExecutionMode(ExecutionMode value) =>
      EncodedObject.encodeObject(value: value, type: ScarabeiClassNames.ExecutionMode_TYPE_STRING);

  Map<String, dynamic> encode(Object flutterObject) {
    if (flutterObject == null) {
      return EncodedObject.encodeNull();
    }
    if (flutterObject is ExecutionMode) {
      return encodeExecutionMode(flutterObject);
    }
    if (flutterObject is ID) {
      return encodeID(flutterObject);
    }
    Err.reportError("Failed to encode <" + flutterObject + ">");
    return null;
  }
}
