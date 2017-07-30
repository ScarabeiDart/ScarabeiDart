import "dart:io" as dart;

import 'package:scarabei_api/api/component_installer.dart';
import 'package:scarabei_api/api/files/file.dart';
import 'package:scarabei_api/api/files/file_system.dart';
import 'package:scarabei_api/api/path/absolute_path.dart';


class LocalFileSystem {
  static ComponentInstaller<
      LocalFileSystemComponent> _componentInstaller = new ComponentInstaller<
      LocalFileSystemComponent>("LocalFileSystem");

  static void installComponent(LocalFileSystemComponent component_to_install) {
    _componentInstaller.installComponent(component_to_install);
  }


  static LocalFileSystemComponent deInstallCurrentComponent() {
    return _componentInstaller.deInstallComponent();
  }

  static LocalFileSystemComponent invoke() {
    return _componentInstaller.invokeComponent();
  }

  static LocalFileSystemComponent component() {
    return _componentInstaller.getComponent();
  }

  static File newFile(AbsolutePath<FileSystem> file_path) {
    return invoke().newFile(file_path);
  }

//  static FileInputStream newFileInputStream(File newFile) {
//    return invoke().newFileInputStream(newFile);
//  }

  static void copyFolderContentsToFolder(File input_folder, File output_folder) {
    invoke().copyFolderContentsToFolder(input_folder, output_folder);
  }

  static File ApplicationHome() {
    return invoke().ApplicationHome();
  }

  static File newLocalFile(dart.File dartFile) {
    return invoke().newLocalFile(dartFile);
  }

  static void copyFilesTo(Iterable<File> children_list, File to_folder) {
    invoke().copyFilesTo(children_list, to_folder);
  }

//  static String readFileToString(AbsolutePath<FileSystem> file_path) {
//    return invoke().readFileToString(file_path);
//  }

//
//  static FileOutputStream newFileOutputStream(File file) {
//    return invoke().newFileOutputStream(file);
//  }

//  static void writeStringToFile(String string_data, AbsolutePath<FileSystem> file_path) {
//    invoke().writeStringToFile(string_data, file_path);
//  }

  static void copyFileToFolder(File file, File to_folder) {
    invoke().copyFileToFolder(file, to_folder);
  }

  static File ROOT() {
    return invoke().ROOT();
  }

  static void copyFileToFile(File inputFile, File outputFile, {bool overwrite(File fileToCopy, File existing)}) {
    invoke().copyFileToFile(inputFile, outputFile);
  }

  static void setDeleteSwitch({bool deleteSwitchSafePosition}) {
    invoke().setDeleteSwitch(deleteSwitchSafePosition: deleteSwitchSafePosition);
  }
}

abstract class LocalFileSystemComponent implements FileSystem {

  File newLocalFile(dart.File dartFile);

  File ApplicationHome();


}
