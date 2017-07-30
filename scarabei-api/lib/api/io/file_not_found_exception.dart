import 'package:scarabei_api/api/io/io_exception.dart';

class FileNotFoundException extends IOException {

  FileNotFoundException(String message) : super(message);

  @override
  String toString() => 'FileNotFoundException{: $message}';
}
