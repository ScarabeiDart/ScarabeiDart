import 'package:scarabei/api/log/logger.dart';

class Again {
  static void again() {
    L.d("hello");
    L.e("hello");

    List<String> list = [];
    list.add("A");
    list.add("B");
    list.add("C");
    L.d("list", list);

    Map<String, String> map = {};
    map.addAll({"A": "1"});
    map.addAll({"B": "2"});
    map.addAll({"C": "3"});

    L.d("map", map);
  }
}