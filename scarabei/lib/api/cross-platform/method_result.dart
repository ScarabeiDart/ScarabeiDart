import 'package:scarabei/api/names/names.dart';

class MethodResult {
  static const String RESULT_NAME = "methodName";
  static const String RESULT_SUCCESS_FLAG = "success";
  static const String RESULT_OBJECT = "result";
  static const String RESULT_ERROR = "error";

  ID methodName;
  bool success;
  dynamic result;
  Exception error;
}
