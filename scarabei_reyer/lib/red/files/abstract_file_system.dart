import 'package:scarabei/api/debug/debug.dart';
import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/files/file.dart';
import 'package:scarabei/api/files/file_system.dart';
import 'package:scarabei/api/io/file_not_found_exception.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei/api/md5/md5.dart';
import 'package:scarabei/api/md5/md5_string.dart';
import 'package:scarabei/api/utils/utils.dart';

abstract class AbstractFileSystem implements FileSystem {
  File _ROOT;

  File ROOT() {
    if (this._ROOT == null) {
      this._ROOT = this.newFile(Utils.newAbsolutePath(this));
    }
    return this._ROOT;
  }

  void setDeleteSwitch({bool deleteSwitchSafePosition}) {
    _deleteSwitchIsInSafePosition = deleteSwitchSafePosition;
  }

  bool _deleteSwitchIsInSafePosition = false;

  bool deleteSwitchIsInSafePosition() {
    return this._deleteSwitchIsInSafePosition;
  }

  MD5String md5Hex(File file) {
    List<int> data = file.readBytes();
    return MD5.hashBytes(bytes: data);
  }

  AbstractFileSystem() {
    this.ROOT();
  }

  void copyFileToFolder(File file_to_copy, File to_folder, {bool overwrite(File fileToCopy, File existing)}) {
    Debug.checkTrue(file_to_copy.exists(), "The file or folder does not exist: " + file_to_copy.toString());
    if (overwrite == null) {
      overwrite = (x, y) => true;
    }
    if (file_to_copy.isFolder()) {
      String shortName = file_to_copy.getName();
      File target_folder = to_folder.child(shortName);
      bool continueCopying = true;
      if (continueCopying) {
        this.copyFolderContentsToFolder(file_to_copy, target_folder, overwrite: overwrite);
      }
    } else {
      if (file_to_copy.isFile()) {
        String shortName = file_to_copy.getName();
        File target_output_file = to_folder.child(shortName);
        bool continueCopying = true;
        if (continueCopying) {
          this.copyFileToFile(file_to_copy, target_output_file, overwrite: overwrite);
        }
      } else {
        Err.reportError("Weirdo file: " + file_to_copy.toString());
      }
    }
  }

  void copyFolderContentsToFolder(File input_folder, File ouput_folder, {bool overwrite(File fileToCopy, File existing)}) {
    Debug.checkTrue(input_folder.exists(), "The folder does not exist: " + input_folder.toString());
    Debug.checkTrue(input_folder.exists(), "This is not a folder: " + input_folder.toString());
    ouput_folder.makeFolder();
    List<File> children = input_folder.listDirectChildren().toList();
    for (int i = 0; i < children.length; i++) {
      File file_to_copy = children.elementAt(i);
      this.copyFileToFolder(file_to_copy, ouput_folder, overwrite: overwrite);
    }
  }


  void copyFilesTo(Iterable<File> files_list, File to_folder) {
    for (int i = 0; i < files_list.length; i++) {
      File file_to_copy = files_list.elementAt(i);
      this.copyFileToFolder(file_to_copy, to_folder);
    }
  }



  void copyFileToFile(File input_file, File output_file, {bool overwrite(File fileToCopy, File existing)}) {
    if (!input_file.exists()) {
      throw new FileNotFoundException("File not found: " + input_file.toString());
    }
    if (input_file.isFolder()) {
      this.copyFolderContentsToFolder(input_file, output_file, overwrite: overwrite);
      return;
    }
    if (input_file.isFile()) {
      if ((!output_file.exists()) || overwrite(input_file, output_file)) {
        L.d("copying file", input_file);
        L.d("          to", output_file.getAbsoluteFilePath());
        List<int> data = input_file.readBytes();
        output_file.parent().makeFolder();
        output_file.writeBytes(bytes: data);
      } else {}
      return;
    }
  }

  bool isReadOnlyFileSystem() {
    return false;
  }
}

