abstract class RelativePath {

  String getPathString();

  static final String SEPARATOR = "/";

  RelativePath parent();

  String nameWithoutExtension();

  String getExtension();

  bool isRoot();

  RelativePath child(String name);

  List<String> steps();

  String getLastStep();

  bool beginsWith(RelativePath other);

  RelativePath proceed(RelativePath value);

  int size();

  RelativePath splitAt(int step);

  RelativePath removeStep(int index);

  String getStep(int index);
}
