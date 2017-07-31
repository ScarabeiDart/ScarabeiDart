library com.jfixby.scarabei.red.filesystem.virtual;

import 'package:scarabei/api/error/err.dart';
import 'package:scarabei/api/log/logger.dart';
import 'package:scarabei_reyer/red/files/virtual/content_leaf.dart';


class ContentNode {
  Map<String, ContentNode> nodes = {};
  Map<String, ContentLeaf> leafs = {};

  void clearAll() {
    this.leafs.clear();
    this.nodes.clear();

//    leafs
//    .
  }

  ContentNode getChildNode(String child_name) {
    return this.nodes[child_name];
  }

  ContentLeaf getChildLeaf(String child_name) {
    return this.leafs[child_name];
  }

  void removeLeaf(String leaf) {
    this.leafs.remove(leaf);
  }

  void removeNode(String node) {
    this.nodes.remove(node);
  }

  void renameNode(String node, String new_name) {
    ContentNode object = this.nodes.remove(node);
//    this.nodes.put(new_name, object);
    this.nodes[new_name] = object;

//        .put(new_name, object);
  }

  void renameLeaf(String leaf, String new_name) {
    ContentLeaf object = this.leafs.remove(leaf);
    this.leafs[new_name] = object;
  }

  List<String> listAllChildren() {
    List<String> result = [];
    result.addAll(this.leafs.keys);
    result.addAll(this.nodes.keys);
    return result;
  }

  ContentNode createNewNode(String name) {
    if (this.leafs.containsKey(name) || this.nodes.containsKey(name)) {
      Err.reportError("File already exists: " + name);
    }
    ContentNode new_node = new ContentNode();
    this.nodes[name] = new_node;
    return new_node;
  }

  ContentLeaf createNewFile(String name) {
    if (this.nodes.containsKey(name)) {
      L.e("Folder with this name already exists: " + name);
      return null;
    }
    ContentLeaf new_file = this.leafs[name];
    if (new_file == null) {
      new_file = new ContentLeaf();
      this.leafs
      [name] = new_file;
    }
    return
      new_file;
  }
}
