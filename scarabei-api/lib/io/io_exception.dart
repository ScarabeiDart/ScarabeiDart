import 'dart:io' as dart;

class IOException extends dart.IOException {
  final String message;

  IOException(this.message);

  @override
  String toString() => 'IOException{: $message}';
}