import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/scarabei_reyer.dart';

class SimpleTable implements Table {
  SimpleDB db;
  String tableName;
  SimpleTableSchema schema;

  @override
  String toString() {
    return 'SimpleTable{tableName: $tableName, schema: $schema}';
  }

  List<Entry> entries = [];
  File entriesFile;

  SimpleTable(final SimpleDB simpleDB, final String tableName, final SimpleTableSchema schema) {
    this.db = simpleDB;
    this.tableName = tableName;
    this.schema = schema;
    final String fileName = this.db.getDBName().child(tableName).child("json").toString();
    this.entriesFile = this.db.storageFolder.child(fileName);
    if (this.entriesFile.exists()) {
      this.readStorage();
    } else {
      this.writeStorage();
    }
  }

  void writeStorage() {
    final List<Map<String, Object>> table = [];
    for (final Entry e in this.entries) {
      table.add(this.srlzEntry(e));
    }
    final JsonString json = Json.serializeToString(table);
    L.d("writing", this.entriesFile);
    this.entriesFile.writeString(json.toString());
  }

  Map<String, Object> srlzEntry(final Entry e) {
    final Map<String, Object> s = {};
    for (final String key in this.schema.columns) {
      s[key] = Codecs.encode(e.getValue(key));
    }
    return s;
  }

  void readStorage() {
    L.d("reading", this.entriesFile);
    final String data = this.entriesFile.readString();
    final List<Map<String, Object>> srlz = Json.deserializeFromString(rawString: data);
    for (final Map<String, Object> e in srlz) {
      final Entry entry = this.deSrlzEntry(e);
      this.entries.add(entry);
    }
  }

  Entry deSrlzEntry(final Map<String, Object> e) {
    final SimpleEntry entry = this.newEntry();
    for (final String k in e.keys) {
      entry.set(k, Codecs.decode(e[k]));
    }
    return entry;
  }

  SimpleEntry newEntry() {
    return new SimpleEntry(this);
  }

  TableSchema getSchema() {
    return this.schema;
  }

  Iterable<Entry> listAll() {
    List<Entry> result = [];
    result.addAll(entries);
    return result;
  }

  void addEntry(final Entry entry) {
    this.entries.add(this.copyValues(entry));
    this.writeStorage();
  }

  void addEntries(final Iterable<Entry> batch) {
    for (final Entry entry in batch) {
      this.entries.add(this.copyValues(entry));
    }
    this.writeStorage();
  }

  void clear() {
    this.entries.clear();
    this.writeStorage();
  }

  void replaceEntries(final Iterable<Entry> batch) {
    for (final Entry newe in batch) {
      for (final Entry stored in this.entries) {
        if (this.isTheSame(newe, stored)) {
          this.copyValues(newe, stored);
        }
      }
    }
    this.writeStorage();
  }

  Entry copyValues(final Entry from, [Entry to = null]) {
    if (to == null) {
      to = this.newEntry();
    }
    final SimpleEntry e = from as SimpleEntry;
    final Iterable<String> vars = e.values.keys;
    for (final String key in vars) {
      final Object val = from.getValue(key);
      to.setValue(key, val);
    }
    return to;
  }

  Iterable<Entry> findEntries(final String key, final Object value) {
    final List<Entry> result = [];
    for (final Entry e in this.entries) {
      final Object val = e.getValue(key);
      if (val == (value)) {
        result.add(this.copyValues(e));
      }
    }
    return result;
  }

  bool deleteEntryWithValue(final String key, final Object value) {
    final Iterable<Entry> toDelete = this.findEntries(key, value);
    if (toDelete.length == 0) {
      return false;
    }
    this.deleteEntries(toDelete);
    return true;
  }

  bool deleteEntry(final Entry entry) {
    for (final Entry e in this.entries) {
      if (this.isTheSame(e, entry)) {
        this.entries.remove(e);
        this.writeStorage();
        return true;
      }
    }
    return false;
  }

  bool isTheSame(final Entry x, final Entry y) {
    return x == (y);
  }

  void deleteEntries(final Iterable<Entry> paramEntries) {
    for (final Entry d in paramEntries) {
      for (final Entry e in this.entries) {
        if (this.isTheSame(e, d)) {
          this.entries.remove(e);
          break;
        }
      }
    }
    this.writeStorage();
  }

  String getName() {
    return this.tableName;
  }

  void drop() {
    this.entries.clear();
    this.entriesFile.delete();
  }
}
