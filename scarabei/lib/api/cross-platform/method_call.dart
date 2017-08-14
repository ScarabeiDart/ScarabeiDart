import 'package:scarabei/api/cross-platform/method_argument.dart';
import 'package:scarabei/api/names/names.dart';

class MethodCall {
  static const String METHOD_NAME = "methodName";
  static const String METHOD_ARGUMENTS = "methodArguments";

  ID methodName;
  List<MethodArgument> callArguments;
}