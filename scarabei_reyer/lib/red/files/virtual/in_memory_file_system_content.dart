import 'package:scarabei/api/path/relative_path.dart';
import 'package:scarabei_reyer/red/files/virtual/content_leaf.dart';
import 'package:scarabei_reyer/red/files/virtual/content_node.dart';

class InMemoryFileSystemContent {
  ContentNode ROOT;

  InMemoryFileSystemContent() {
    this.ROOT = new ContentNode();
  }

  bool isFile(RelativePath relativePath) {
    if (relativePath.isRoot()) {
      return false;
    }
    ContentLeaf content = this.findLeaf(relativePath);
    return content != null;
  }

  int lastModified(RelativePath relativePath) {
    ContentLeaf content = this.findLeaf(relativePath);
    return content.lastModified();
  }

  bool isFolder(RelativePath relativePath) {
    ContentNode content = this.findNode(relativePath);
    return content != null;
  }

  ContentNode findNode(RelativePath relativePath) {
    if (relativePath.isRoot()) {
      return this.ROOT;
    }
    List<String> steps = relativePath.steps();
    ContentNode node_cursor = this.ROOT;
    int steps_cursor = (-1);
    while ((steps_cursor + 1) < steps.length) {
      steps_cursor++;
      String next_step_name = steps.elementAt(steps_cursor);
      node_cursor = node_cursor.getChildNode(next_step_name);
      if (node_cursor == null) {
        return null;
      }
    }
    return node_cursor;
  }

  ContentLeaf findLeaf(RelativePath relativePath) {
    ContentNode leaf_parent = this.findNode(relativePath.parent());
    if (leaf_parent == null) {
      return null;
    } else {
      String child_name = relativePath.getLastStep();
      ContentLeaf leaf = leaf_parent.getChildLeaf(child_name);
      return leaf;
    }
  }

  bool delete(RelativePath relativePath) {
    if (relativePath.isRoot()) {
      this.ROOT.clearAll();
      return false;
    }
    ContentNode leaf_parent = this.findNode(relativePath.parent());
    if (leaf_parent == null) {
      return false;
    } else {
      String child_name = relativePath.getLastStep();
      ContentLeaf leaf = leaf_parent.getChildLeaf(child_name);
      if (leaf != null) {
        leaf_parent.removeLeaf(child_name);
        return true;
      } else {
        ContentNode node = leaf_parent.getChildNode(child_name);
        if (node != null) {
          leaf_parent.removeNode(child_name);
          return true;
        }
      }
    }
    return false;
  }

  bool exists(RelativePath relativePath) {
    return this.isFile(relativePath) || this.isFolder(relativePath);
  }

  bool mkdirs(RelativePath relativePath) {
    if (relativePath.isRoot()) {
      return true;
    }
    var steps = relativePath.steps();
    ContentNode node_cursor = this.ROOT;
    ContentNode parent = null;
    int steps_cursor = (-1);
    while ((steps_cursor + 1) < steps.length) {
      steps_cursor++;
      String next_step_name = steps.elementAt(steps_cursor);
      ContentLeaf bad_leaf = node_cursor.getChildLeaf(next_step_name);
      if (bad_leaf != null) {
        return false;
      }
      parent = node_cursor;
      node_cursor = node_cursor.getChildNode(next_step_name);
      if (node_cursor == null) {
        node_cursor = parent.createNewNode(next_step_name);
      }
    }
    return true;
  }

  void rename(RelativePath relativePath, String new_name) {
    if (relativePath.isRoot()) {
      return;
    }
    ContentNode leaf_parent = this.findNode(relativePath.parent());
    if (leaf_parent == null) {
      return;
    } else {
      String child_name = relativePath.getLastStep();
      ContentLeaf leaf = leaf_parent.getChildLeaf(child_name);
      if (leaf != null) {
        leaf_parent.renameLeaf(child_name, new_name);
      } else {
        ContentNode node = leaf_parent.getChildNode(child_name);
        if (node != null) {
          leaf_parent.renameNode(child_name, new_name);
        }
      }
    }
  }

  List<String> listChildren(RelativePath relativePath) {
    ContentNode leaf = this.findNode(relativePath);
    if (leaf == null) {
      return null;
    } else {
      return leaf.listAllChildren();
    }
  }

  ContentLeaf createFile(RelativePath relativePath) {
    ContentNode leaf_parent = this.findNode(relativePath.parent());
    String name = relativePath
        .steps()
        .last;
    return leaf_parent.createNewFile(name);
  }

  ContentLeaf getContentLeaf(RelativePath relativePath) {
    return this.findLeaf(relativePath);
  }
}
