import 'package:scarabei_api/files/file.dart';


abstract class FilesList extends Iterable<File> {

  File findChild(String short_child_name);

  FilesList filter(bool fileFilter(File file));

  FilesList filterByExtension(String extension);

  int size();

  void deleteAll();

  File getElementAt(int i);
}
