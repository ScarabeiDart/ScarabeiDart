library com.jfixby.scarabei.red.filesystem.virtual;

import 'java.dart';

class InMemoryFileSystem extends com_jfixby_scarabei_red_filesystem_AbstractFileSystem with com_jfixby_scarabei_api_file_FileSystem
{
    static String OS_SEPARATOR = "/";
    InMemoryFileSystemContent content = new InMemoryFileSystemContent();

    InMemoryFile newFile(com_jfixby_scarabei_api_util_path_AbsolutePath<FileSystem> file_path)
    {
        if (file_path == null) {
            Err.reportError("Filepath is null.");
        }
        if (file_path.getMountPoint() != this) {
            Err.reportError("Path does not belong to this filesystem: " + file_path);
        }
        return new InMemoryFile(this, file_path);
    }

    com_jfixby_scarabei_api_file_FileOutputStream newFileOutputStream(com_jfixby_scarabei_api_file_File output_file, bool append)
    {
        if (output_file == null) {
            Err.reportError("Output file is null.");
        }
        if (output_file.getFileSystem() != this) {
            Err.reportError("Output file does not belong to this filesystem: " + output_file);
        }
        return new InMemoryFileOutputStream(output_file, append);
    }

    com_jfixby_scarabei_api_file_FileInputStream newFileInputStream(com_jfixby_scarabei_api_file_File input_file)
    {
        if (input_file == null) {
            Err.reportError("Input file is null.");
        }
        if (input_file.getFileSystem() != this) {
            Err.reportError("Input file does not belong to this filesystem: " + input_file);
        }
        return new InMemoryFileInputStream(input_file);
    }
    String name = "InMemoryFileSystem";

    static String toNativePathString(String string)
    {
        return string;
    }

    String toString()
    {
        return this.name;
    }

    InMemoryFileSystemContent getContent()
    {
        return this.content;
    }

    String getName()
    {
        return this.name;
    }
}
