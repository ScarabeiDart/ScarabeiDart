import 'package:scarabei_api/files/file.dart';
import 'package:scarabei_api/path/absolute_path.dart';
import 'package:scarabei_api/path/mount_point.dart';


abstract class FileSystem extends MountPoint {

  File ROOT();

  File newFile(AbsolutePath<FileSystem> file_path);

  void copyFileToFolder(File file_to_copy, File to_folder, {bool overwrite(File fileToCopy, File existing)});

  void copyFolderContentsToFolder(File forlder_from, File folder_to, {bool overwrite(File fileToCopy, File existing)});

  void copyFileToFile(File input_file, File output_file, {bool overwrite(File fileToCopy, File existing)});

  void copyFilesTo(Iterable<File> files_list, File to_folder);

  bool isReadOnlyFileSystem();

  bool deleteSwitchIsInSafePosition();

  void setDeleteSwitch({bool deleteSwitchSafePosition});

//  Stream<List<int>> newInputStream(AbsolutePath<FileSystem> file_path);
//
//  dart.IOSink newOutputStream(AbsolutePath<FileSystem> file_path, {bool append});
}
