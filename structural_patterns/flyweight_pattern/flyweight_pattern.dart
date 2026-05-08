/*
Flyweight Pattern Implementation in Dart
Example: Forest with Trees

Problem without flyweight: each tree is a separate object with its own data.
  → high memory usage when many trees are created.
Flyweight pattern shares common data (intrinsic state) among multiple objects.
In this example, TreeType is the flyweight (shared object) that contains intrinsic state.
Tree is the context that contains extrinsic state (position) and a reference to the flyweight.
TreeTypeFactory ensures that only one instance of each TreeType is created and shared.
*/

// The Flyweight (shared object)
class TreeType {
  final String name;
  final String color;
  final String texture;

  TreeType(this.name, this.color, this.texture);

  void draw(int x, int y) {
    print(
        'Drawing $name tree of color $color and texture $texture at ($x, $y)');
  }
}

// Flyweight Factory
class TreeTypeFactory {
  static final Map<String, TreeType> _treeTypes = {};

  static TreeType getTreeType(String name, String color, String texture) {
    final key = '$name-$color-$texture';
    if (!_treeTypes.containsKey(key)) {
      _treeTypes[key] = TreeType(name, color, texture);
    }
    return _treeTypes[key]!;
  }
}

// Context (extrinsic state)
class Tree {
  final int x;
  final int y;
  final TreeType type;

  Tree(this.x, this.y, this.type);

  void draw() {
    type.draw(x, y);
  }
}

// Forest (client)
class Forest {
  final List<Tree> _trees = [];

  void plantTree(int x, int y, String name, String color, String texture) {
    final type = TreeTypeFactory.getTreeType(name, color, texture);
    final tree = Tree(x, y, type);
    _trees.add(tree);
  }

  void draw() {
    for (var tree in _trees) {
      tree.draw();
    }
  }
}

void main() {
  final forest = Forest();
  forest.plantTree(1, 2, 'Oak', 'Green', 'Rough');
  forest.plantTree(3, 4, 'Pine', 'Dark Green', 'Smooth');
  forest.plantTree(
      5, 6, 'Oak', 'Green', 'Rough'); // Shares the same TreeType as the first
  forest.draw();
}
