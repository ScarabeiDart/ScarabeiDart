import 'package:scarabei_api/files/local_file_system.dart';
import 'package:scarabei_red/files/posix/unix_file_system.dart';

//import com.jfixby.scarabei.api.file.LocalFileSystemComponent;
//import com.jfixby.scarabei.red.filesystem.LocalFileSystem;

class AndroidFileSystem extends UnixFileSystem  {


  String toString() {
    return "AndroidFileSystem";
  }

}
