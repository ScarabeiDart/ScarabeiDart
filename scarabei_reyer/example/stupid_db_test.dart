import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/scarabei_reyer.dart';

main() {
  ScarabeiDesktop.deploy();
  SystemSettings.setExecutionMode(ExecutionMode.DEMO);

  final SimpleDBConfig cfg = new SimpleDBConfig();
  cfg.dbName = Names.newID(string: "test.db");
  cfg.dbStorageFolder = LocalFileSystem.ApplicationHome().child("dbFolder");
  bool dbFromScratch = !true;
  if (dbFromScratch) {
    cfg.dbStorageFolder.clearFolder();
  }

  final SimpleDB db = new SimpleDB(cfg);
  if (!db.init(true)) {
    db.init(false);
  }
  final String table1name = "table1";
  {
    final SimpleTableSpecs specs = db.newTableSpecs();

    specs.tableName = table1name;
    specs.addColumn("x");
    specs.addColumn("y");
    specs.addColumn("z");
    if (dbFromScratch) {
      final SimpleTable newTable = db.newTable(specs);
    }
  }
  final Table table1 = db.getTable(table1name);
  {
    final Iterable<Entry> all = table1.listAll();
    L.d("all", all);
  }

  final Entry e = table1.newEntry();
  e.setValue("x", "1");
  e.setValue("y", "sdfsdfsdf");
  table1.addEntry(e);
  {
    final Iterable<Entry> all = table1.listAll();
    L.d("all", all);
  }
// table1.clear();
  final Iterable<Entry> good = table1.findEntries("y", "sdfsdfsdf");
  L.d("good", good);
  {
    final Iterable<Entry> all = table1.listAll();
    L.d("all", all);
  }
}
