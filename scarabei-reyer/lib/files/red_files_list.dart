import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/files_list.dart';

class RedFilesList
    implements FilesList {
  List<File> internal_list = [];

  List<File> filter(CollectionFilter<File> filter) {
    return this.internal_list.filter(filter);
  }

  void add(com_jfixby_scarabei_api_file_File absolute_file) {
    this.internal_list.add(absolute_file);
  }

  java_util_Iterator<File> iterator() {
    return this.internal_list.iterator();
  }

  void addAllArrayElements(List<com_jfixby_scarabei_api_file_File> array) {
    this.internal_list.addAllArrayElements(array);
  }

  bool contains(Object element) {
    return this.internal_list.contains(element);
  }

  bool containsAll(Collection list) {
    for (int i = 0; i < list.size(); i++) {
      if (!this.contains(list.getElementAt(i))) {
        return false;
      }
    }
    return true;
  }

  bool remove(Object element) {
    return this.internal_list.remove(element);
  }

  int size() {
    return this.internal_list.size();
  }

  void addAll(Collection<File> list) {
    this.internal_list.addAll(list);
  }

  com_jfixby_scarabei_api_file_File findChild(String short_file_name) {
    for (int i = 0; i < this.internal_list.size(); i++) {
      com_jfixby_scarabei_api_file_File element = this.internal_list.getElementAt(i);
      if (true) {
        String element_short_file_name = element.getName();
        if (element_short_file_name == short_file_name) {
          return element;
        }
      }
    }
    return null;
  }

  String toString() {
    return ("FilesList" + this.internal_list) + "";
  }

  com_jfixby_scarabei_api_file_FilesList filter(com_jfixby_scarabei_api_file_FileFilter filter) {
    RedFilesList result = new RedFilesList();
    for (int i = 0; i < this.size(); i++) {
      com_jfixby_scarabei_api_file_File child = this.getElementAt(i);
      if (filter.fits(child)) {
        result.add(child);
      }
    }
    return result;
  }

  List<File> toJavaList() {
    return this.internal_list.toJavaList();
  }

  com_jfixby_scarabei_api_file_File getElementAt(int i) {
    return this.internal_list.getElementAt(i);
  }

  com_jfixby_scarabei_api_file_File getLast() {
    return this.internal_list.getLast();
  }

  List<File> toList() {
    return this.internal_list.toList();
  }

  bool isEmpty() {
    return this.internal_list.isEmpty();
  }

  void print(String tag) {
    this.internal_list.print(tag);
  }

  void print(String tag, int from_index, int to_index) {
    this.internal_list.print(tag, from_index, to_index);
  }

  bool beginsWith(Collection<File> steps) {
    return this.internal_list.beginsWith(steps);
  }

  com_jfixby_scarabei_api_file_FilesList filterByExtension(String extention) {
    return this.filter(EXTENSION_FILTER);
  }

  void deleteAll() {
    for (int i = 0; i < this.size(); i++) {
      this.getElementAt(i).delete();
    }
  }

  int indexOf(Object element) {
    return this.internal_list.indexOf(element);
  }
}
