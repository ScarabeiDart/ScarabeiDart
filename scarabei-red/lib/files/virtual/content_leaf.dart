import 'package:scarabei_api/sys/sys.dart';

class ContentLeaf {
  int last_edit = Sys.currentTime();

  List<int> data = [];

  List<int> getData() {
    return data;
  }

  void setData(List<int> data) {
    this.data = data;
    last_edit = Sys.currentTime();
  }

  int lastModified() {
    return last_edit;
  }

  int size() => data.length;
}
