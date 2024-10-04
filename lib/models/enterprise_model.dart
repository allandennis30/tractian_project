class EnterpriseModel {
  final String id;
  final String name;

  EnterpriseModel({required this.id, required this.name});

  factory EnterpriseModel.fromJson(Map<String, dynamic> json) {
    return EnterpriseModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
