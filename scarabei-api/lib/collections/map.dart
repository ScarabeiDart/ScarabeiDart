import 'package:scarabei_api/collections/collection.dart';
import 'package:scarabei_api/collections/editable_collection.dart';
import 'package:scarabei_api/collections/mapping.dart';

abstract class SMap<K, V> extends Mapping<K, V> {

  void put(K key, V value);

  void clear();

  V remove(Object key);

  void putAll(Mapping<K, V> other_map);

  void putDartMap(Map<K, V> dart_map);

  void removeAll(Collection<K> keys);

  void sortKeys([Comparator<K> keysComparator]);

  EditableCollection<K> cutToSize(int max_size);
}

