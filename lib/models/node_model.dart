class NodeModel {
  NodeModel({
    this.id,
    this.name,
    this.parentId,
    this.isAsset = false,
    this.children,
  });

  final String? id;
  final String? name;
  final String? parentId;
  final bool isAsset;
  late List<NodeModel>? children;
}
