class MethodResult {
  static const String RESULT_SUCCESS_FLAG = "success";
  static const String RESULT_OBJECT = "result";
  static const String RESULT_ERROR = "error";

  bool success;
  dynamic result;
  Exception error;
}
