import 'package:scarabei/api/cross-platform/class_names.dart';

abstract class FromDartEncoder {
  bool canEncode(Object flutterObject);

  Map<String, dynamic> encode(Object flutterObject);
}

class EncodedObject {
  static const String VALUE = "value";
  static const String TYPE = "type";

  static Map<String, dynamic> encodeNull() => encodeObject(value: null, type: CrossLanguageClassNames.NULL);

  static Map<String, dynamic> encodeObject({dynamic value, String type}) => {VALUE: value, TYPE: type};

  static Map<String, dynamic> encodeString(String value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.STRING);

  static Map<String, dynamic> encodeBool(bool value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.BOOL);

  static Map<String, dynamic> encodeMethod(bool value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.BOOL);

  static Map<String, dynamic> encodeInt(int value) =>
      EncodedObject.encodeObject(value: value.toString(), type: CrossLanguageClassNames.INTEGER);

  static Map<String, dynamic> encodeDecimal(double value) =>
      EncodedObject.encodeObject(value: value.toString(), type: CrossLanguageClassNames.INTEGER);

  static Map<String, dynamic> encodeIterable(Iterable<dynamic> value) =>
      EncodedObject.encodeObject(value: value, type: CrossLanguageClassNames.LIST);

}
