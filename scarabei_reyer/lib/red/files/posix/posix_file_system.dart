import 'package:scarabei/api/files/local_file_system.dart';
import 'package:scarabei_reyer/red/files/red_local_file_system.dart';


abstract class PosixFileSystem extends RedLocalFileSystem
    implements LocalFileSystemComponent {

  String toString() {
    return "PosixFileSystem";
  }
}
