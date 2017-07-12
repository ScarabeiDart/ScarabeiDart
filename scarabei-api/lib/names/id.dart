library com.jfixby.scarabei.api.assets;


abstract class ID {
  static String SEPARATOR = ".";

  ID child(String string);

  ID parent();

  String getLastStep();

  bool includes(ID other);

  ID proceed(ID subpackage);

  List<String> steps();
}
