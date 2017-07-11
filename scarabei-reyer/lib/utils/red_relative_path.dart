library com.jfixby.scarabei.red.util;

import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/path/relative_path.dart';
import 'package:scarabei_api/utils/jutils.dart';

class RedRelativePath extends RelativePath {

  List<String> path_steps = [];
  String string;

  RedRelativePath({Iterable<String> path_steps, String relative_path_string}) {
    if (path_steps != null) {
      this.path_steps.addAll(path_steps);
      this.string = pathToString(this.path_steps);
    } else if (relative_path_string != null) {
      Debug.checkNull("relative_path_string", relative_path_string);
      List<String> parts_array = relative_path_string.split(RelativePath.SEPARATOR);
      List<String> parts_list = (parts_array);
      while (parts_list.contains(E)) {
        parts_list.remove(E);
      }
      this.path_steps.addAll(parts_list);
      this.string = pathToString(this.path_steps);
    } else {
      Err.reportError("null");
    }
  }


  static String pathToString(Iterable<String> path_steps) {
    int n = path_steps.length;
    if (n == 0) {
      return E;
    }
    String builder = "";
    int i = 0;
//    i < n; i++
    for (String step in path_steps) {
      if (i == 0) {
        builder = builder + (step);
      } else {
        builder = builder + (RelativePath.SEPARATOR) + (step);
      }
      i++;
    }
    return builder.toString();
  }


  static String E = "";

  String getPathString() {
    return this.string;
  }

  RelativePath parent() {
    List<String> path_steps = [];
    path_steps.addAll(this.path_steps);
    if (this.isRoot()) {
      Err.reportError("This is already a root path. No parent available.");
    }
    path_steps.removeLast();
    return new RedRelativePath(path_steps: path_steps);
  }

  bool isRoot() {
    return this.path_steps.length == 0;
  }

  List<String> steps() {
    var result = new List<String>();
    result.addAll(this.path_steps);
    return result;
  }

  child(String name) {
    var result = new List<String>();
    result.addAll(this.path_steps);
    result.add(name);
    return new RedRelativePath(path_steps: result);
  }

  String toString() {
    return this.string;
  }


  String getLastStep() {
    return this.path_steps.elementAt(path_steps.length - 1);
  }

  String getStep(int index) {
    return this.path_steps.elementAt(index);
  }


  bool beginsWith(RelativePath other) {
    Debug.checkNull(other, "other");
    if (this == other) {
      return true;
    }
    return Utils.beginsWith(this.steps(), other.steps());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RedRelativePath &&
              runtimeType == other.runtimeType &&
              path_steps == other.path_steps;

  @override
  int get hashCode => path_steps.hashCode;

  RelativePath proceed(RelativePath value) {
    Debug.checkNull(value);
    List<String> steps = new List.from(this.path_steps);
    steps.addAll(value.steps());
    RelativePath incremented = new RedRelativePath(path_steps: steps);
    return incremented;
  }

  int size() {
    return this
        .steps()
        .length;
  }

  String nameWithoutExtension() {
    String name = this.getLastStep();
    int dotIndex = name.lastIndexOf('.');
    if (dotIndex == (-1)) {
      return name;
    }
    return name.substring(0, dotIndex);
  }

  String getExtension() {
    String name = this.getLastStep().toLowerCase();
    int index = name.lastIndexOf('.');
    if (index < 0) {
      return null;
    }
    String ext = name.substring(index + 1);
    return ext;
  }

  RelativePath splitAt(int step) {
    return new RedRelativePath(path_steps: this.steps().sublist(0, step));
  }

  RelativePath removeStep(int index) {
    List<String> newPath = this.steps().toList();
    newPath.removeAt(index);
    return new RedRelativePath(path_steps: newPath);
  }
}
