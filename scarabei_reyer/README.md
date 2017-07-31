# scarabei_reyer

Default implementations if the scarabei API

Installation
```Java
    L.installComponent(new SimpleLogger()); //logger
    Err.installComponent(new RedError()); //errors reporter
    Debug.installComponent(new RedDebug()); // asserts for debug and testing
    Utils.installComponent(new RedUtils()); //utils including the path-factory

    {
    
      //here we install a Windows file-system
      LocalFileSystem.installComponent(new WinFileSystem());
      
      //Windows is POSIX now too
      LocalFileSystem.deInstallCurrentComponent();
      LocalFileSystem.installComponent(new UnixFileSystem());
      
      // Android
      LocalFileSystem.deInstallCurrentComponent();
      LocalFileSystem.installComponent(new AndroidFileSystem());
      //This was the last line where we cared about the filesystem type (PISIX/Windows)
      //From this moment onwards, the path works in a generic way.
      

    }


    Json.installComponent(new DartJson());
    Strings.installComponent(new RedStrings()); // some utils for strings
    Sys.installComponent(new RedAndroidSystem()); //...
    SystemSettings.installComponent(new RedSystemSettings()); //...
    SystemSettings.setExecutionMode(ExecutionMode.EARLY_DEVELOPMENT); // activate debugging flags
    SystemSettings.setExecutionMode(ExecutionMode.PUBLIC_RELEASE); // deactivate production mode

    MD5.installComponent(new RedMD5());
  ```



