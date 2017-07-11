import 'package:scarabei_api/utils/byte_array.dart';

class RedByteArray extends ByteArray {
  List<int> _bytes;

  RedByteArray({List<int> bytes, int size}) {
    _bytes = bytes;
    if (_bytes == null) {
      _bytes = [];
      _bytes = new List<int>.filled(size, 0);
    }
  }

  @override
  int getByte(int i) {
    return _bytes.elementAt(i);
  }

  @override
  int size() {
    return _bytes.length;
  }

  @override
  List<int> toArray() {
    return new List.from(_bytes);
  }
}