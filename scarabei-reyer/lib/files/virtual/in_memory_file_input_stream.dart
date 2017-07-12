library com.jfixby.scarabei.red.filesystem.virtual;

import 'java.dart';

class InMemoryFileInputStream extends com_jfixby_scarabei_red_io_AbstractRedInputStream<RedInMemoryFileInputStreamOperator> with com_jfixby_scarabei_api_file_FileInputStream
{
    InMemoryFile file;

    InMemoryFileInputStream(InMemoryFile file)
    {
        super(new RedInMemoryFileInputStreamOperator(file));
        this.file = file;
    }

    int getFileSize()
    {
        return this.file.getSize();
    }
}
