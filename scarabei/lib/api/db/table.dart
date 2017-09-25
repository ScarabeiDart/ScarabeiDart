import 'package:scarabei/scarabei.dart';

abstract class Table {
  Entry newEntry();

  TableSchema getSchema();

  Iterable<Entry> listAll();

  void addEntry(Entry entry);

  void addEntries(Iterable<Entry> batch);

  void clear();

  void replaceEntries(Iterable<Entry> batch);

  Iterable<Entry> findEntries(String key, Object value);

  bool deleteEntryWithValue(String key, final Object value);

  bool deleteEntry(Entry entry);

  void deleteEntries(Iterable<Entry> paramEntries);

  String getName();
}
