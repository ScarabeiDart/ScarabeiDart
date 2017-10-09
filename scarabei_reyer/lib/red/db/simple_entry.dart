import 'package:scarabei/scarabei.dart';
import 'package:scarabei_reyer/scarabei_reyer.dart';

class SimpleEntry implements Entry {
  SimpleTable table;

  SimpleEntry(final SimpleTable table) {
    this.table = table;
  }

  String toString() {
    return "" + this.values.toString() + "";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SimpleEntry && runtimeType == other.runtimeType && values == other.values;

  @override
  int get hashCode => values.hashCode;

//  bool equals(final Object obj) {
//    if (this == obj) {
//      return true;
//    }
//    if (obj == null) {
//      return false;
//    }
//    if (this.getClass() != obj.getClass()) {
//      return false;
//    }
//    final SimpleEntry other = (SimpleEntry)
//    obj;
//    if (this.values == null) {
//      if (other.values != null) {
//        return false;
//      }
//    } else if (!this.sameMaps(this.values, other.values)) {
//      return false;
//    }
//    return true;
//  }

  bool sameMaps(final Map<String, Object> x, final Map<String, Object> y) {
    if (x == y) {
      return true;
    }
    for (final String k in x.keys) {
      final Object Vx = x[k];
      final Object Vy = y[k];
      if (!Utils.equalObjects(Vx, Vy)) {
        return false;
      }
    }
    return true;
  }

  final Map<String, Object> values = {};

  Object getValue(final String parameterName) {
    return this.values[parameterName];
  }

  void setValue(final String key, final Object value) {
    final bool hasKey = this.getOwner().getSchema().indexOf(key) >= 0;
    if (!hasKey) {
      L.e("schema columns", this.getOwner().getSchema().getColumns());
    }

    Debug.checkTrue(hasKey, "Key<" + key + "> exists");
    this.values[key] = value;
  }

  void set(final String key, final Object value) {
    final bool hasKey = this.getOwner().getSchema().indexOf(key) >= 0;
    if (!hasKey) {
      L.e("schema columns", this.getOwner().getSchema().getColumns());
      throw new IOException("Key<" + key + "> exists");
    }

    this.values[key] = value;
  }

  Table getOwner() {
    return this.table;
  }
}
