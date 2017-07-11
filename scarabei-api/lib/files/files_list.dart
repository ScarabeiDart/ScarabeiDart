import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/file_filter.dart';


abstract class FilesList extends Iterable<File> {

  File findChild(String short_child_name);

  FilesList filter(FileFilter filter);

  FilesList filterByExtension(String extension);

  void deleteAll();
}
