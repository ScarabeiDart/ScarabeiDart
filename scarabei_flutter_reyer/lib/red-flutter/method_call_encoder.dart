import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/names/names.dart';

class MethodCallEncoder {
  static Map<String, dynamic> encodeMethod(ID methodName, List<Map<String, dynamic>> arguments) {
    Map<String, dynamic> method = <String, dynamic>{'methodName': methodName.toString(), 'arguments': arguments};
    String jsonString = Json.serializeToString(method).toString();
    Map<String, dynamic> call = <String, dynamic>{
      'jsonString': '$jsonString',
    };
    return call;
  }
}
