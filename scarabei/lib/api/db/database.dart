import 'package:scarabei/scarabei.dart';

abstract class DataBase {

  Table getTable(String tableName);

  ID getDBName();

  DBEditor getEditor();

}
