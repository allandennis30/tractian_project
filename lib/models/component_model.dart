class ComponentModel {
  ComponentModel(
      {required this.id,
      required this.name,
      this.parentId,
      required this.sensorType});

  final String id;
  final String name;
  final String? parentId;
  final String sensorType;

  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    return ComponentModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
    );
  }
}
