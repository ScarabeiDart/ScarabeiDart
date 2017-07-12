library com.jfixby.scarabei.red.filesystem.virtual;

import 'java.dart';

class RedInMemoryFileOutputStreamOperator with com_jfixby_scarabei_api_io_JavaOutputStreamOperator
{
    ContentLeaf leaf;
    com_jfixby_scarabei_api_io_BufferOutputStream os;
    InMemoryFile v_file;
    bool append;

    RedInMemoryFileOutputStreamOperator(InMemoryFile output_file, bool append)
    {
        this.v_file = output_file;
        this.append = append;
    }

    void closeStream()
    {
        if (this.os == null) {
            return;
        }
        this.os.close();
        com_jfixby_scarabei_api_java_ByteArray data = this.os.getBytes();
        this.leaf.setData(data);
        this.os = null;
    }

    OutputStream getJavaStream()
    {
        if (this.os == null) {
            this.leaf = this.v_file.getContent();
            if (this.leaf == null) {
                this.leaf = this.v_file.createFile();
                if (this.leaf == null) {
                    throw new java_io_IOException("Unable to write to the file: " + this.v_file);
                }
            }
            this.os = IO.newBufferOutputStream();
            this.os.open();
            if (this.append) {
                this.os.write(this.leaf.getData());
            }
        }
        return this.os.toJavaOutputStream();
    }

    bool isBulkWriteSupported()
    {
        return true;
    }

    void writeAll(com_jfixby_scarabei_api_java_ByteArray bytes)
    {
        this.leaf = this.v_file.getContent();
        if (this.leaf == null) {
            this.leaf = this.v_file.createFile();
            if (this.leaf == null) {
                throw new java_io_IOException("Unable to write to the file: " + this.v_file);
            }
        }
        this.leaf.setData(bytes);
    }
}
