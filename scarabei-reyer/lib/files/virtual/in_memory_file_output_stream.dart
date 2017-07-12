library com.jfixby.scarabei.red.filesystem.virtual;

import 'java.dart';

class InMemoryFileOutputStream extends com_jfixby_scarabei_red_io_AbstractRedOutputStream<RedInMemoryFileOutputStreamOperator> with com_jfixby_scarabei_api_file_FileOutputStream
{

    InMemoryFileOutputStream(InMemoryFile output_file, bool append)
    {
        super(new RedInMemoryFileOutputStreamOperator(output_file, append));
    }
}
