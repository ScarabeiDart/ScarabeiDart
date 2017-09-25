import 'package:scarabei/scarabei.dart';

abstract class Entry {
  Object getValue(String key);

  void setValue(String key, Object value);

  Table getOwner();
}
