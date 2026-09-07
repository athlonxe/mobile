/// Model layanan FixMate dengan serialisasi JSON manual dan strict null safety.
class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.iconName,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final String duration;
  final String iconName;

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Layanan',
      description: json['description'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      duration: json['duration'] as String? ?? '-',
      iconName: json['iconName'] as String? ?? 'build',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration': duration,
      'iconName': iconName,
    };
  }
}
