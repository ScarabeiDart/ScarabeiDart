library com.jfixby.scarabei.red.filesystem;

import 'java.dart';

class RedFolderSupportingIndexBuilderParams with com_jfixby_scarabei_api_file_FolderSupportingIndexBuilderParams
{
    com_jfixby_scarabei_api_file_File home;
    bool rebuildRootOnly;
    bool ignoreHashSum;
    bool noOutput;
    bool debug;
    bool recoursive = true;
    bool ignoreJsonDecoderFailure = false;

    RedFolderSupportingIndexBuilderParams(RedFolderSupportingIndexBuilderParams redFolderSupportingIndexBuilderParams)
    {
        this.home = redFolderSupportingIndexBuilderParams.home;
        this.rebuildRootOnly = redFolderSupportingIndexBuilderParams.rebuildRootOnly;
        this.ignoreHashSum = redFolderSupportingIndexBuilderParams.ignoreHashSum;
        this.noOutput = redFolderSupportingIndexBuilderParams.noOutput;
        this.debug = redFolderSupportingIndexBuilderParams.debug;
    }

    RedFolderSupportingIndexBuilderParams_()
    {
    }

    void setTarget(com_jfixby_scarabei_api_file_File home)
    {
        this.home = home;
    }

    void setRebuidOnlyForRoot(bool b)
    {
        this.rebuildRootOnly = b;
    }

    void setIgnoreHashSum(bool b)
    {
        this.ignoreHashSum = b;
    }

    void setNoOutput(bool b)
    {
        this.noOutput = b;
    }

    void setDebug(bool b)
    {
        this.debug = b;
    }

    com_jfixby_scarabei_api_file_FolderSupportingIndexBuilderParams copy()
    {
        return new RedFolderSupportingIndexBuilderParams(this);
    }

    com_jfixby_scarabei_api_file_File getTarget()
    {
        return this.home;
    }

    bool getDebug()
    {
        return this.debug;
    }

    bool ignoreHashSum()
    {
        return this.ignoreHashSum;
    }

    bool rebuidOnlyForRoot()
    {
        return this.rebuildRootOnly;
    }

    bool noOutput()
    {
        return this.noOutput;
    }

    void setRecoursive(bool recoursive)
    {
        this.recoursive = recoursive;
    }

    bool recoursive()
    {
        return this.recoursive;
    }

    bool ignoreJsonDecoderFailure()
    {
        return this.ignoreJsonDecoderFailure;
    }

    void setIgnoreJsonDecoderFailure(bool b)
    {
        this.ignoreJsonDecoderFailure = b;
    }
}
