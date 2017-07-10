import 'package:scarabei_api/collections/editable_collection.dart';

abstract class SList<T> extends EditableCollection<T> {

  void addElement(T element);

}