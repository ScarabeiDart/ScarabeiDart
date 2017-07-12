library com.jfixby.scarabei.red.filesystem.virtual;

import 'java.dart';

class ContentNode
{
    com_jfixby_scarabei_api_collections_Map<String, ContentNode> nodes = Collections.newMap();
    com_jfixby_scarabei_api_collections_Map<String, ContentLeaf> leafs = Collections.newMap();

    void clearAll()
    {
        this.leafs.clear();
        this.nodes.clear();
    }

    ContentNode getChildNode(String child_name)
    {
        return this.nodes.get(child_name);
    }

    ContentLeaf getChildLeaf(String child_name)
    {
        return this.leafs.get(child_name);
    }

    void removeLeaf(String leaf)
    {
        this.leafs.remove(leaf);
    }

    void removeNode(String node)
    {
        this.nodes.remove(node);
    }

    void renameNode(String node, String new_name)
    {
        ContentNode object = this.nodes.remove(node);
        this.nodes.put(new_name, object);
    }

    void renameLeaf(String leaf, String new_name)
    {
        ContentLeaf object = this.leafs.remove(leaf);
        this.leafs.put(new_name, object);
    }

    com_jfixby_scarabei_api_collections_List<String> listAllChildren()
    {
        com_jfixby_scarabei_api_collections_List<String> result = Collections.newList();
        result.addAll(this.leafs.keys());
        result.addAll(this.nodes.keys());
        return result;
    }

    ContentNode createNewNode(String name)
    {
        if (this.leafs.containsKey(name) || this.nodes.containsKey(name)) {
            Err.reportError("File already exists: " + name);
        }
        ContentNode new_node = new ContentNode();
        this.nodes.put(name, new_node);
        return new_node;
    }

    ContentLeaf createNewFile(String name)
    {
        if (this.nodes.containsKey(name)) {
            L.e("Folder with this name already exists: " + name);
            return null;
        }
        ContentLeaf new_file = this.leafs.get(name);
        if (new_file == null) {
            new_file = new ContentLeaf();
            this.leafs.put(name, new_file);
        }
        return new_file;
    }
}
