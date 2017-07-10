import 'package:scarabei_api/collections/collection.dart';
import 'package:scarabei_api/collections/map.dart';


abstract class Mapping<K, V> {

  bool containsKey(Object key);

  V get(Object key);

  void print(String tag);

  int size();

  K getKeyAt(int i);

  V getValueAt(int i);

  Iterator<K> keysIterator();

  Collection<V> values();

  Collection<K> keys();

  SMap<K, V> toDartMap();
}