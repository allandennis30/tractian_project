class NodeModel {
  NodeModel({
    this.id,
    this.name,
    this.parentId,
    this.isAsset = false,
    this.children,
    this.isComponent = false,
    this.locationId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.sensorId,
    this.depth = 0,
  });

  final String? id;
  final String? name;
  final String? parentId;
  final bool isAsset;
  final bool isComponent;
  final String? locationId;
  late List<NodeModel>? children;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? sensorId;
  int depth;
}
