import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/files/file_input_stream.dart';
import 'package:scarabei_api/files/file_output_stream.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/mount_point.dart';
import 'package:scarabei_api/utils/byte_array.dart';


abstract class FileSystem extends MountPoint {

  File ROOT();

  File newFile(AbsolutePath<FileSystem> file_path);

  FileOutputStream newFileOutputStream(File output_file, {bool append});

  FileInputStream newFileInputStream(File input_file);

  void copyFileToFolder(File file_to_copy, File to_folder, {bool overwrite(File fileToCopy, File existing)});


  void copyFolderContentsToFolder(File forlder_from, File folder_to, {bool overwrite(File fileToCopy, File existing)});


  void copyFileToFile(File input_file, File output_file, {bool overwrite(File fileToCopy, File existing)});

  void copyFilesTo(Iterable<File> files_list, File to_folder);

  String readFileToString(AbsolutePath<FileSystem> file_path);

  void writeDataToFile(AbsolutePath<FileSystem> file_path, ByteArray bytes);

  void writeStringToFile(String string_data, AbsolutePath<FileSystem> file_path);

  bool isReadOnlyFileSystem();

  bool deleteSwitchIsInSafePosition();
}
