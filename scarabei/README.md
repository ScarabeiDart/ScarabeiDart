# ScarabeiDart

[![Pub Package](https://img.shields.io/pub/v/scarabei.svg)](https://pub.dartlang.org/packages/scarabei)
[![GitHub Issues](https://img.shields.io/github/issues/ScarabeiDart/ScarabeiDart.svg)](https://github.com/ScarabeiDart/ScarabeiDart/issues)
[![GitHub Forks](https://img.shields.io/github/forks/ScarabeiDart/ScarabeiDart.svg)](https://github.com/ScarabeiDart/ScarabeiDart/network)
[![GitHub Stars](https://img.shields.io/github/stars/ScarabeiDart/ScarabeiDart.svg)](https://github.com/ScarabeiDart/ScarabeiDart/stargazers)
[![GitHub License](https://img.shields.io/badge/license-Apache-blue.svg)](https://raw.githubusercontent.com/ScarabeiDart/ScarabeiDart/master/LICENSE)

*Набор Dart-компонентов, чтобы катать всякое говно*

Similar to the Apache Commons (https://commons.apache.org/) Scarabei library provides a collection of open-source reusable components that you are missing in the official SDK.

Originally written in Java (https://github.com/Scarabei/Scarabei/tree/master/scarabei-api/src/com/jfixby/scarabei/api) ScarabeiDart is a port to the Dart-language.

Scarabei strongly relies on the facade design pattern (https://en.wikipedia.org/wiki/Facade_pattern) shielding your code from external libraries with an abstract API. The actual implementations of the API will be determined during runtime. The approach allows more flexibility in the development e.g. optional implementations and dependency injections (https://en.wikipedia.org/wiki/Dependency_inversion_principle) (https://en.wikipedia.org/wiki/Dependency_injection).

> The intent behind dependency injection is to decouple objects to the extent that no client code has to be changed simply because an object it depends on needs to be changed to a different one.

The proposed usage scenario for the library user (client library) is the following:
 - develop and compile your library code using Scarabei API 
 - setup the actual implementations at the runtime right after your application entry point
 
## Usage examples
### Logger
```Dart
L.d("Hello world");
L.d("message", message);
L.e("error", exception);
```

### File systems
```Dart
 Iterable<String> relativePathSteps = ['folderA', 'foo', 'bar', '1.txt']; //some strings

  RelativePath relative = Utils.newRelativePath(path_steps: relativePathSteps);
  // RelativePath is just a list of Strings with some useful operations like: child(), parent(), beginsWith() and so on.
  // We can reverse it, split or join. Anything you like.

//  L.d(""); this is how we print the logs here to a local console or to a remote log server;
  L.d("relative", relative); //prints the path to console > folderA/foo/bar/1.txt

  /*Now we can mount this relative path.
    - to root of a local file system
    - or to a web-site, like https://pub.dartlang.org/folderA/foo/bar/1.txt
    - or to InMemory file system (see below)
    - remote file system
    - or maybe it is a path in a binary tree or in a graph? Doesn't matter. It is generic!
*/

  //Let's try it.
  //First we need a mount point. Let it be a local file system.
  FileSystem fileSystem = LocalFileSystem.invoke();

  //AbsolutePath is simply a composition of a mount point and a relative path. Let's compose it:
  AbsolutePath<FileSystem> pathAtFileSystem = Utils.newAbsolutePath(fileSystem, relative); // mount_point + relative = [filesystem]+path
  L.d("pathAtFileSystem", pathAtFileSystem);
  //AbsolutePath is not necessary a file-path as it was said above. It can be AbsolutePath<ZipArchiveFileSystem> or anything else.

  //Good. Now we can create files;
  File file = fileSystem.newFile(pathAtFileSystem);
  // let's go to the parent
  File parent = file.parent();
  //or the other way;
  var parentPath = pathAtFileSystem.parent();
  File sameParent = fileSystem.newFile(parentPath);

  //Let's see what we have here:
  L.d("parent", parent); // parent > @[PosixFileSystem] folderA/foo/bar
  L.d("sameParent", sameParent); //sameParent > @[PosixFileSystem] folderA/foo/bar/


  //Now where we are?
  File home = LocalFileSystem.ApplicationHome();
  L.d("home", home); // @[PosixFileSystem] C:/ScarabeiDart/ScarabeiDart/scarabei-desktop-red-example

  // Safety Pig
  // We will get to back to it later.
  //
  //  _._ _..._ .-',     _.._(`))
  // '-. `     '  /-._.-'    ',/
  //    )         \            '.
  //   / _    _    |             \
  //  |  a    a    /              |
  //  \   .-.                     ;
  //   '-('' ).-'       ,'       ;
  //      '-;           |      .'
  //         \           \    /
  //         | 7  .__  _.-\   \
  //         | |  |  ``/  /`  /
  //        /,_|  |   /,_/   /
  //           /,_/      '`-'


  //Let's see what we have here
  L.d("home.dir", home.listAllChildren()); //*all files in the current folder*

  //Lets go to the  folderA/foo/bar/1.txt
  File txtFile = home.proceed(relative); //C:/ScarabeiDart/ScarabeiDart/scarabei-desktop-red-example/folderA/foo/bar/1.txt
  txtFile.writeString("Hello txt file!");

  //Now let's try something else. Like InMemoryFileSystem.
  InMemoryFileSystem virtual = new InMemoryFileSystem();
  File root = virtual.ROOT(); //it is empty

  //Let's copy the whole current directory to the root.
  fileSystem.copyFolderContentsToFolder(home, root);

  //Let's see the result;
  L.d("virtual file system content", root.listAllChildren());

  //Now let's copy it back to the hard drive
  File tmp = home.child("tmp");
  fileSystem.copyFolderContentsToFolder(root, tmp);

  //tmp contains a copy of the 1.txt file, let's find it;
  File txtFileCopy = tmp.proceed(relative);
  String message = txtFileCopy.readString();
  L.d("message", message); //"Hello txt file!" Hello, fella!

  //time to clean-up the mess;
  tmp.delete();
  File folderA = home.child(relative.getStep(0));
  folderA.delete();

  // Now actually if you look carefully you'll see that our code depends on an abstract file API and doesn't care about what is behind it.
  // Everything happening after the safety pig doesn't know anything about the filesystem of each file.
  // It can be a content of Amazon S3-bucket, an Android  APK file, or a bridge duplicating all IO operations on two hard drives.
  //
  // Actually I wrote some massive code to pack game-assets for my games. And my code uses similar approach in Java. (Because java.io.File sucks a lot).
  // So the assets packer reads some files, places them in temp directories and deploys all the stuff at the S3 bucket. Tha bucket is published via web server.
  // Later game engine downloads assets from web-server and deploys it at a local cache.
  // For all of these I use:
  // 1) InMemoryFileSystem - to store temp folders and to speed-up the packing process
  // 2) S3BucketFileSystem - to upload assets to the assets server
  // 3) HTTPFileSystem - reads files from a web server. This one is read-only.
  // 4) And of course WindowsFileSystem is my local machine and PosixFileSystem for Android and iOS devices.
  //
  // Since the assets-packer and the game engine are working only with the abstraction (AbsolutePath<FileSystem> and the File)
  // they don't know anything about these file systems.  No idea if it is Posix or Windows or anything else.
  //

  Sys.exit(); //Thank you for your time.
  ```
