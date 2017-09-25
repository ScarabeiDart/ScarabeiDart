import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/scarabei_reyer.dart';

class SimpleDB implements DataBase {
  ID dbName;
  Map<String, SimpleTable> tables = {};
  File storageFolder;
  File dbFile;

  bool inited;

  SimpleDB(final SimpleDBConfig config) {
    this.dbName = config.dbName;
    Debug.checkNull(this.dbName, "dbName");
    this.storageFolder = config.dbStorageFolder;
    Debug.checkNull(this.storageFolder, "storageFolder");
    this.dbFile = this.storageFolder.child(this.dbName.child("json").toString());
  }

  bool init(final bool readFromStorage) {
    this.inited = true;
    try {
      if (readFromStorage) {
        this.readStorage();
        return true;
      } else {
        this.writeStorage();
        return true;
      }
    } catch (e, s) {
      L.e(e);
      return false;
    }
  }

  void readStorage() {
    final String string = this.dbFile.readString();
    L.d("reading", this.dbFile);
    final Map<String, List<String>> schema = Json.deserializeFromString(rawString: string);
    for (final String tableName in schema.keys) {
      final List<String> sztSchema = schema[tableName];
      final SimpleTableSchema tSchema = this.deserialize(sztSchema);
      final SimpleTable table = new SimpleTable(this, tableName, tSchema);
      this.tables[tableName] = table;
      L.d("   table loaded", table);
    }
  }

  SimpleTableSchema deserialize(final List<String> sztSchema) {
    final SimpleTableSchema s = new SimpleTableSchema();
    s.addAll(sztSchema);
    return s;
  }

  SimpleTable newTable(final SimpleTableSpecs specs) {
    final String tableName = specs.tableName;
    Debug.checkNull("tableName", tableName);
    Debug.checkEmpty("tableName", tableName);
    if (this.tables.containsKey(tableName)) {
      throw new IOException("Table already exists<" + tableName + ">");
    }

    final SimpleTableSchema tSchema = new SimpleTableSchema();
    tSchema.addAll(specs.columns);
    final SimpleTable table = new SimpleTable(this, tableName, tSchema);
    this.tables[tableName] = table;
    L.d("   table created", table);
    this.writeStorage();
    return table;
  }

  void writeStorage() {
    final Map<String, List<String>> schema = {};
    for (final String key in this.tables.keys) {
      final SimpleTable val = this.tables[key];
      final List<String> srlzdSchema = this.serialize(val.getSchema());
      schema[key] = srlzdSchema;
    }

    final String data = Json.serializeToString(schema).toString();
    L.d("writing", this.dbFile);
    this.dbFile.writeString(data);
  }

  List<String> serialize(final TableSchema tableSchema) {
    final List<String> s = [];
    for (final String k in tableSchema.getColumns()) {
      s.add(k);
    }
    return s;
  }

  @override
  Table getTable(final String tableName) {
    Debug.checkNull("tableName", tableName);
    this.storageFolder.makeFolder();

    final SimpleTable table = this.tables[tableName];
    if (table == null) {
      throw new IOException("Table<" + tableName + "> not found");
    }
    return table;
  }

  @override
  ID getDBName() {
    return this.dbName;
  }

  void drop() {
    for (final SimpleTable t in this.tables.values) {
      t.drop();
    }
    this.tables.clear();
    this.writeStorage();
  }

  SimpleTableSpecs newTableSpecs() {
    return new SimpleTableSpecs();
  }

  Iterable<String> listTables() {
    return this.tables.keys;
  }

  @override
  DBEditor getEditor() {
    Err.throwNotImplementedYet();
    return null;
  }
}
