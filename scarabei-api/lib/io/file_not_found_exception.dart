import 'dart:io';

class FileNotFoundException extends IOException {
  final String _message;

  FileNotFoundException(this._message);

  @override
  String toString() => 'FileNotFoundException{: $_message}';
}
