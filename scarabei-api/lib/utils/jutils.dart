import 'package:scarabei_api/component_installer.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/mount_point.dart';
import 'package:scarabei_api/path/relative_path.dart';
import 'package:scarabei_api/utils/byte_array.dart';


class Utils {
  static ComponentInstaller<
      UtilsComponent> _componentInstaller = new ComponentInstaller<
      UtilsComponent>("Utils");


  static void installComponent(UtilsComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }

  static UtilsComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static UtilsComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static UtilsComponent component() {
    return _componentInstaller.getComponent();
  }


  static RelativePath newRelativePath({Iterable<String> path_steps, String relative_path_string}) {
    return invoke().newRelativePath(path_steps: path_steps, relative_path_string: relative_path_string);
  }

  static AbsolutePath<T> newAbsolutePath<T extends MountPoint>(T mount_point, [RelativePath relative]) {
    return invoke().newAbsolutePath(mount_point, relative);
  }

  static List<String> split(String input_string, String splitter) {
    return invoke().split(input_string, splitter);
  }

//  static String truncated(String data, int begin_char, int end_char) {
//    return invoke().truncated(data, begin_char, end_char);
//  }

  static bool equalObjects(Object a, Object b) {
    return invoke().equalObjects(a, b);
  }

  static ByteArray newByteArray(List<int> bytes) {
    return invoke().newByteArray(bytes: bytes);
  }

  static bool beginsWith(Iterable listA, Iterable listB) {
    return invoke().beginsWith(listA, listB);
  }

}

abstract class UtilsComponent {

  RelativePath newRelativePath({Iterable<String> path_steps, String relative_path_string});

  AbsolutePath<T> newAbsolutePath<T extends MountPoint>(T mount_point, [RelativePath relative]);

  List<String> split(String input_string, String splitter);

//  String newString(ByteArray data);

//  String truncated(String data, int begin_char, int end_char);

  bool equalObjects(Object a, Object b);

  ByteArray newByteArray({List<int> bytes, int size});

  bool beginsWith(Iterable listA, Iterable listB);


}
