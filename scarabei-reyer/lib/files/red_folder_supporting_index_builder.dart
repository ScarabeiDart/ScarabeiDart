library com.jfixby.scarabei.red.filesystem;

import 'java.dart';

class RedFolderSupportingIndexBuilder
{

    static com_jfixby_scarabei_api_file_FolderSupportingIndex rebuild(com_jfixby_scarabei_api_file_FolderSupportingIndexBuilderParams params)
    {
        com_jfixby_scarabei_api_file_File file = params.getTarget();
        if (!file.isFolder()) {
            Err.reportError("Is not folder " + file);
        }
        if (params.getDebug()) {
            L.d(file);
        }
        com_jfixby_scarabei_api_file_FilesList children = file.listDirectChildren();
        com_jfixby_scarabei_api_file_FolderSupportingIndex desc = new com_jfixby_scarabei_api_file_FolderSupportingIndex();
        Collections.scanCollection(children, COLLECTION_BUILDER_SCANNER);
        if (!params.noOutput()) {
            com_jfixby_scarabei_api_file_FolderSupportingIndex deckCheck = null;
            com_jfixby_scarabei_api_file_File desc_file = file.child(FolderSupportingIndex_.FILE_NAME);
            L.d("writing", desc_file);
            com_jfixby_scarabei_api_file_FileOutputStream os = desc_file.newOutputStream();
            os.open();
            HTTPOperator.encode(desc, os);
            os.close();
            com_jfixby_scarabei_api_java_ByteArray dataCheck = desc_file.readBytes();
            deckCheck = HTTPOperator.decode(dataCheck);
            com_jfixby_scarabei_api_file_File desc_file_json = file.child(FolderSupportingIndex_.FILE_NAME + ".json");
            L.d("writing", desc_file_json);
            com_jfixby_scarabei_api_json_JsonString stringData = Json.serializeToString(desc);
            com_jfixby_scarabei_api_json_JsonString testStringData = Json.serializeToString(deckCheck);
            String s1 = stringData.toString();
            String s2 = testStringData.toString();
            if (!(s1 == s2)) {
                String message = "decoder fails";
                L.e("    stringData " + s1.length);
                L.e("testStringData " + s2.length);
                L.e(desc_file_json);
                if (params.ignoreJsonDecoderFailure()) {
                    L.e(message);
                } else {
                    Err.reportError(message);
                }
            }
            String data = stringData.toString();
            desc_file_json.writeString(data);
        }
        return desc;
    }
}
