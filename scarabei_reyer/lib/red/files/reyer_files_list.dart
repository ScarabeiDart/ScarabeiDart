import 'dart:core';

import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/files/files_list.dart';

class ReyerFilesList implements FilesList {
  final List<File> list = [];

  ReyerFilesList(Iterable<File> list) {
    this.list.addAll(list);
  }

  @override
  void deleteAll() {
    for (File f in list) {
      f.delete();
    }
  }

  @override
  FilesList filter(FileFilter fileFilter) {
    var filtered = this.toList().where(fileFilter);
    return new ReyerFilesList(filtered);
  }

  @override
  Iterable<File> toList() {
    List<File> res = [];
    res.addAll(list);
    return res;
  }


}
