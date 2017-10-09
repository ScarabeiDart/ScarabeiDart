import 'package:scarabei/scarabei.dart';

class SimpleTableSchema implements TableSchema {
  final List<String> columns = [];

  @override
  String toString() {
    return '$columns}';
  }

  SimpleTableSchema() {}

  int indexOf(final String key) {
    return this.columns.indexOf(key);
  }

  Iterable<String> getColumns() {
    return this.columns;
  }

  void addAll(final Iterable<String> columns) {
    for (final String c in columns) {
      if (c == null) {
        throw new IOException("Column name is NULL");
      }
      if (c == "") {
        throw new IOException("Column name is empty");
      }
      this.columns.add(c);
    }
  }
}
