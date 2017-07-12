library com.jfixby.scarabei.red.filesystem.virtual;

import 'java.dart';

class InMemoryFile extends com_jfixby_scarabei_red_filesystem_AbstractRedFile with com_jfixby_scarabei_api_file_File
{
    InMemoryFileSystem virtualFileSystem;
    com_jfixby_scarabei_api_util_path_AbsolutePath<FileSystem> absolute_path;
    com_jfixby_scarabei_api_util_path_RelativePath relativePath;

    InMemoryFile(InMemoryFileSystem virtualFileSystem, com_jfixby_scarabei_api_util_path_AbsolutePath<FileSystem> file_path)
    {
        this.virtualFileSystem = virtualFileSystem;
        this.absolute_path = file_path;
        this.relativePath = file_path.getRelativePath();
    }

    com_jfixby_scarabei_api_util_path_AbsolutePath<FileSystem> getAbsoluteFilePath()
    {
        return this.absolute_path;
    }

    bool delete()
    {
        if (this.isFolder()) {
            this.clearFolder();
        }
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        return content.delete(this.absolute_path.getRelativePath());
    }

    bool isFolder()
    {
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        return content.isFolder(this.absolute_path.getRelativePath());
    }

    bool isFile()
    {
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        return content.isFile(this.absolute_path.getRelativePath());
    }

    com_jfixby_scarabei_api_file_FilesList listDirectChildren()
    {
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        if (!content.exists(this.relativePath)) {
            Err.reportError("File does not exist: " + this.absolute_path);
        }
        if (content.isFolder(this.relativePath)) {
            com_jfixby_scarabei_api_collections_List<String> files = content.listChildren(this.relativePath);
            com_jfixby_scarabei_red_filesystem_RedFilesList listFiles = new com_jfixby_scarabei_red_filesystem_RedFilesList();
            for (int i = 0; i < files.size(); i++) {
                String file_i = files.getElementAt(i);
                com_jfixby_scarabei_api_util_path_AbsolutePath<FileSystem> absolute_file = this.absolute_path.child(file_i);
                listFiles.add(absolute_file.getMountPoint().newFile(absolute_file));
            }
            return listFiles;
        } else {
            Err.reportError("This is not a folder: " + this.absolute_path);
        }
        return null;
    }

    com_jfixby_scarabei_api_file_File child(String child_name)
    {
        return new InMemoryFile(this.getFileSystem(), this.absolute_path.child(child_name));
    }

    bool exists()
    {
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        return content.exists(this.absolute_path.getRelativePath());
    }

    bool makeFolder()
    {
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        return content.mkdirs(this.absolute_path.getRelativePath());
    }

    bool rename(String new_name)
    {
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        content.rename(this.absolute_path.getRelativePath(), new_name);
        this.absolute_path = this.absolute_path.parent().child(new_name);
        this.relativePath = this.absolute_path.getRelativePath();
        return true;
    }

    String getName()
    {
        if (this.relativePath.isRoot()) {
            return this.virtualFileSystem.getName();
        }
        return this.absolute_path.getName();
    }

    InMemoryFileSystem getFileSystem()
    {
        return this.virtualFileSystem;
    }

    String nameWithoutExtension()
    {
        String name = this.getName();
        int dotIndex = name.lastIndexOf('.'.codeUnitAt(0));
        if (dotIndex == (-1)) {
            return name;
        }
        return name.substring(0, dotIndex);
    }

    ContentLeaf createFile()
    {
        if (this.relativePath.isRoot()) {
            return null;
        }
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        if (!content.mkdirs(this.relativePath.parent())) {
            return null;
        }
        return content.createFile(this.relativePath);
    }

    ContentLeaf getContent()
    {
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        return content.getContentLeaf(this.relativePath);
    }

    int getSize()
    {
        if (this.isFile()) {
            return this.getContent().getData().size();
        } else {
            return 0;
        }
    }

    DartFile toJavaFile()
    {
        Err.reportError("The method is not supported");
        return null;
    }

    com_jfixby_scarabei_api_file_File parent()
    {
        return new InMemoryFile(this.virtualFileSystem, this.absolute_path.parent());
    }

    int lastModified()
    {
        InMemoryFileSystemContent content = this.virtualFileSystem.getContent();
        return content.lastModified(this.absolute_path.getRelativePath());
    }
}
