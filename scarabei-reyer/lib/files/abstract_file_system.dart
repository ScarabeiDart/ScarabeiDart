import 'package:scarabei_api/debug/debug.dart';
import 'package:scarabei_api/error/err.dart';
import 'package:scarabei_api/files/file.dart';
import "package:scarabei_api/files/file_system.dart";
import 'package:scarabei_api/io/file_not_found_exception.dart';
import 'package:scarabei_api/log/logger.dart';
import 'package:scarabei_api/md5/md5.dart';
import 'package:scarabei_api/md5/md5_string.dart';
import 'package:scarabei_api/utils/jutils.dart';

abstract class AbstractFileSystem implements FileSystem {
  File _ROOT;

  File ROOT() {
    if (this.ROOT == null) {
      this._ROOT = this.newFile(Utils.newAbsolutePath(this));
    }
    return this._ROOT;
  }

  bool _deleteSwitchIsInSafePosition = (!true);

  bool deleteSwitchIsInSafePosition() {
    return this._deleteSwitchIsInSafePosition;
  }

  MD5String md5Hex(File file) {
    List<int> data = file.readBytes();
    return MD5.hashBytes(bytes: data);
  }


  void copyFileToFolder(File file_to_copy, File to_folder, {bool overwrite(File fileToCopy, File existing)}) {
    Debug.checkTrue(file_to_copy.exists(), "The file or folder does not exist: " + file_to_copy.toString());
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
    List<File> children = input_folder.listDirectChildren();
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

//  String readFileToString(AbsolutePath<FileSystem> file_path) {
//    File file = this.newFile(file_path);
//    FileInputStream is_ = this.newFileInputStream(file);
//    ByteArray data = is_.readAll();
//    is_.close();
//    return Strings.newString(byteArray: data);
//  }
//
//  void writeDataToFile(AbsolutePath<FileSystem> file_path, List<int> bytes) {
//    File file = this.newFile(file_path);
//    FileOutputStream fos = this.newFileOutputStream(file);
//    fos.write(array: bytes);
//    fos.flush();
//    fos.close();
//  }
//
//  void writeStringToFile(String string_data, AbsolutePath<FileSystem> file_path) {
//    this.writeDataToFile(file_path, (Strings.toBytes(string_data)));
//  }


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
        output_file.writeBytes(bytes: data);
      } else {}
      return;
    }
  }

  bool isReadOnlyFileSystem() {
    return false;
  }

//  void convertFolderToFolder(File input_folder, File ouput_folder, FolderConverter folderConverter, FileConverter fileConverter) {
//    Debug.checkTrue("The folder does not exist: " + input_folder, input_folder.exists());
//    Debug.checkTrue("This is not a folder: " + input_folder, input_folder.exists());
//    ouput_folder.makeFolder();
//    FilesList children = input_folder.listDirectChildren();
//    for (int i = 0; i < children.size(); i++) {
//      File file_to_copy = children.getElementAt(i);
//      this.convertFile(file_to_copy, ouput_folder, folderConverter, fileConverter);
//    }
//  }
//
//  void convertFile(File fileToConvert, File targetFolder, FolderConverter folderConverter, FileConverter fileConverter) {
//    Debug.checkTrue("The file or folder does not exist: " + fileToConvert, fileToConvert.exists());
//    String shortName = fileToConvert.getName();
//    File target = targetFolder.child(shortName);
//    if (fileToConvert.isFolder()) {
//      if (folderConverter != null) {
//        bool keep_running = folderConverter.convert(fileToConvert, target);
//        if (keep_running) {
//          this.convertFolderToFolder(fileToConvert, target, folderConverter, fileConverter);
//        }
//      }
//    } else {
//      if (fileToConvert.isFile()) {
//        if (fileConverter != null) {
//          fileConverter.convert(fileToConvert, target);
//        }
//      } else {
//        Err.reportError("Weirdo file: " + fileToConvert);
//      }
//    }
//  }

//  FileConverter COPY_FILE = new COPY_FILE();
//  FolderConverter COPY_FOLDER = new COPY_FOLDER();

//  void rebuildFolderSupportingIndexes(FolderSupportingIndexBuilderParams params) {
//    RedFolderSupportingIndexBuilder.rebuild(params);
//  }
//
//  FolderSupportingIndexBuilderParams newFolderSupportingIndexBuilderParams() {
//    return new RedFolderSupportingIndexBuilderParams();
//  }
}

