/// Model perangkat pelanggan untuk fondasi data Tugas #2.
///
/// Seluruh properti bertipe jelas, memakai named-parameter constructor,
/// dan serialisasi JSON manual yang null-safe.
class LaptopModel {
  const LaptopModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.problem,
    required this.status,
    required this.estimatedCost,
  });

  final String id;
  final String brand;
  final String model;
  final String problem;
  final String status;
  final int estimatedCost;

  String get displayName => '$brand $model';

  factory LaptopModel.fromJson(Map<String, dynamic> json) {
    return LaptopModel(
      id: json['id'] as String? ?? '',
      brand: json['brand'] as String? ?? 'Laptop',
      model: json['model'] as String? ?? 'Tidak diketahui',
      problem: json['problem'] as String? ?? 'Belum ada keluhan',
      status: json['status'] as String? ?? 'Menunggu',
      estimatedCost: json['estimatedCost'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'problem': problem,
      'status': status,
      'estimatedCost': estimatedCost,
    };
  }
}
