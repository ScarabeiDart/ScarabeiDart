import 'package:scarabei_api/api/files/local_file_system.dart';
import 'package:scarabei_api/red/files/red_local_file_system.dart';

class WinFileSystem extends RedLocalFileSystem
    implements LocalFileSystemComponent {

  String toString() {
    return "WinFileSystem";
  }
}
