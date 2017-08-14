class MethodArgument {
  static const String METHOD_ARGUMENT_NAME = "argumentName";
  static const String METHOD_ARGUMENT_VALUE = "argumentValue";

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MethodArgument && argumentName == other.argumentName;

  @override
  int get hashCode => argumentName.hashCode;
  String argumentName;
  dynamic argumentValue;
}
