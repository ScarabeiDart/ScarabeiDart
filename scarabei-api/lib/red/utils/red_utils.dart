import 'package:scarabei_api/api/debug/debug.dart';
import 'package:scarabei_api/api/path/absolute_path.dart';
import 'package:scarabei_api/api/path/mount_point.dart';
import 'package:scarabei_api/api/path/relative_path.dart';
import 'package:scarabei_api/api/utils/utils.dart';
import 'package:scarabei_api/red/utils/red_absolute_path.dart';
import 'package:scarabei_api/red/utils/red_relative_path.dart';

class RedUtils extends UtilsComponent {

  List<String> split(String input_string, String splitter) {
    Debug.checkNull("input_string", input_string);
    Debug.checkNull("splitter", splitter);
    return (input_string.split(splitter));
  }

  RelativePath newRelativePath({Iterable<String> path_steps, String relative_path_string}) {
    return new RedRelativePath(path_steps: path_steps, relative_path_string: relative_path_string);
  }


  AbsolutePath<T> newAbsolutePath<T extends MountPoint>(T mount_point, [RelativePath relative]) {
    return new RedAbsolutePath<T>(mount_point, relative);
  }


//  String newString(ByteArray data) {
//    return this.newString(data.toArray());
//  }

//  String truncated(String data, int begin_char, int end_char) {
//    int beginIndex = IntegerMath.max(begin_char, 0);
//    int endIndex = IntegerMath.min(end_char, data.length);
//    return data.substring(beginIndex, endIndex);
//  }

  bool equalObjects(Object a, Object b) {
    if (a == b) {
      return true;
    }
    if (a == null) {
      return false;
    }
    if (b == null) {
      return false;
    }
    return a == b;
  }


  @override
  bool beginsWith(Iterable listA, Iterable listB) {
    if (listB.length > listA.length) {
      return false;
    }
    for (int i = 0; i < listB.length; i++) {
      var a = listA.elementAt(i);
      var b = listB.elementAt(i);
      if (!Utils.equalObjects(a, b)) {
        return false;
      }
    }
    return true;
  }
}


