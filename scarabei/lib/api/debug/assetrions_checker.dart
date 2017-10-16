abstract class AssertionsChecker {
  void checkTrue(bool value, [String name]);

  String checkEmpty(String string, [String name]);

  T checkNull<T>(T obj, [String name]);
}
