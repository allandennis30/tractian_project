class LocationModel {
  LocationModel({
    this.id,
    this.name,
    this.parentId,
  });

  final String? id;
  final String? name;
  final String? parentId;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
