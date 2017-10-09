class SimpleTableSpecs {
  String tableName;
  final List<String> columns = [];

  void addColumn(final String columnName) {
    this.columns.add(columnName);
  }
}
