library com.jfixby.scarabei.red.filesystem.virtual;

import 'java.dart';

class RedInMemoryFileInputStreamOperator with com_jfixby_scarabei_api_io_JavaInputStreamOperator
{
    InMemoryFile v_file;
    java_io_InputStream is_;

    RedInMemoryFileInputStreamOperator(InMemoryFile input_file)
    {
        this.v_file = input_file;
    }

    void closeStream()
    {
        IO.forceClose(this.is_);
        this.is_ = null;
    }

    java_io_InputStream getJavaStream()
    {
        if (this.is_ == null) {
            ContentLeaf leaf = this.v_file.getContent();
            if (leaf == null) {
                throw new java_io_IOException("File not found: " + this.v_file);
            }
            com_jfixby_scarabei_api_java_ByteArray data = leaf.getData();
            this.is_ = new java_io_ByteArrayInputStream(data.toArray());
        }
        return this.is_;
    }

    bool isReadAllSupported()
    {
        return true;
    }

    com_jfixby_scarabei_api_java_ByteArray readAll()
    {
        ContentLeaf leaf = this.v_file.getContent();
        if (leaf == null) {
            throw new java_io_IOException("File not found: " + this.v_file);
        }
        com_jfixby_scarabei_api_java_ByteArray data = leaf.getData();
        return data;
    }
}
