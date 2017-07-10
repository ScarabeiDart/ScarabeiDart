import 'package:scarabei_api/collections/collection_filter.dart';
import 'package:scarabei_api/collections/iterable.dart';
import 'package:scarabei_api/collections/list.dart';
import 'package:scarabei_api/collections/sequence.dart';

// ignore: conflicting_dart_import, use local Iterator instead
abstract class Collection<T> extends SIterable<T> with Sequence<T> {

  int size();

  bool contains(Object element);

  T getLast();

  SList<T> toList();

  bool isEmpty();

  void print(String tag, [int beginIndex, int endIndex]);

  SList<T> filter(CollectionFilter<T> filter);

  bool beginsWith(Collection<T> steps);

  bool containsAll(Collection other);

  int indexOf(Object element);

  List<T> toDartList();
}