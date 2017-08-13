import 'package:scarabei/api/json/json.dart';
import 'package:scarabei/api/names/names.dart';
import 'package:scarabei/api/sys/execution_mode.dart';

class MethodCallEncoder {
  static List<Map<String, dynamic>> encodeArgument(List<Map<String, dynamic>> arguments,
      {String name, dynamic value, String type}) {
    if (arguments == null) {
      arguments = [];
    }
    Map<String, dynamic> arg = <String, dynamic>{'argumentName': name, 'argumentValue': value, 'argumentType': type};
    arguments.add(arg);
    return arguments;
  }

  static Map<String, dynamic> encodeMethod(ID javaClassID, String methodName, List<Map<String, dynamic>> arguments) {
    Map<String, dynamic> method = <String, dynamic>{
      'methodName': (javaClassID.child(methodName).toString()),
      'arguments': arguments
    };
    String jsonString = Json.serializeToString(method).toString();
    Map<String, dynamic> call = <String, dynamic>{
      'jsonString': '$jsonString',
    };
    return call;
  }

  static List<Map<String, dynamic>> encodeString(List<Map<String, dynamic>> arguments, {String name, String value}) {
    return encodeArgument(arguments, name: name, value: value, type: "String");
  }

  static List<Map<String, dynamic>> encodeBool(List<Map<String, dynamic>> arguments, {String name, bool value}) {
    return encodeArgument(arguments, name: name, value: value, type: "bool");
  }

  static List<Map<String, dynamic>> encodeInt(List<Map<String, dynamic>> arguments, {String name, int value}) {
    return encodeArgument(arguments, name: name, value: value, type: "int");
  }

  static List<Map<String, dynamic>> encodeID(List<Map<String, dynamic>> arguments, {String name, ID value}) {
    return encodeArgument(arguments, name: name, value: value.toString(), type: "ID");
  }

  static List<Map<String, dynamic>> encodeExecutionMode(List<Map<String, dynamic>> arguments,
      {String name, ExecutionMode value}) {
    return encodeArgument(arguments, name: name, value: value.toString(), type: "ExecutionMode");
  }
}
