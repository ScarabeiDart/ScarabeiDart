import 'package:scarabei_api/collections/collection.dart';
import 'package:scarabei_api/collections/iterable.dart';

abstract class EditableCollection<T> extends Collection<T> {

  bool remove(Object element);

  void clear();

  bool add(T element);

  void reverse();

  T removeElementAt(int i);

  T removeLast();

  EditableCollection<T> splitAt(int index);

  EditableCollection<T> addDartCollection(Iterable<T> dart_collection);

  EditableCollection<T> addAll(SIterable <T> list);

  void removeAll(Collection<Object> list);

  void sort([Comparator<T> comparator]);


}