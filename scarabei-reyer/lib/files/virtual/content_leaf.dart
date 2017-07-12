library com.jfixby.scarabei.red.filesystem.virtual;


class ContentLeaf {
  int last_edit = new DateTime.now().millisecondsSinceEpoch;

  List<int> data;

  List<int> getData() {
    return data;
  }

  void setData(List<int> data) {
    this.data = data;
    last_edit = new DateTime.now().millisecondsSinceEpoch;
  }

  int lastModified() {
    return last_edit;
  }
}
