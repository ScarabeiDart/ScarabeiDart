import 'package:scarabei_api/collections/collections.dart';


class RedCollections extends CollectionsComponent {
  @override
  List<T> newList<T>() {
    return new List<T>();
  }

  @override
  Map<K, V> newMap<K, V>() {
    Map<K, V> map = {};
    return map;
  }
}