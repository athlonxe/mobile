/// Model pesanan servis, meneruskan pola data class dan JSON Tugas #2.
class ServiceOrderModel {
  const ServiceOrderModel({
    required this.id,
    required this.laptopName,
    required this.serviceName,
    required this.status,
    required this.progress,
    required this.updatedAt,
  });

  final String id;
  final String laptopName;
  final String serviceName;
  final String status;
  final double progress;
  final String updatedAt;

  factory ServiceOrderModel.fromJson(Map<String, dynamic> json) {
    return ServiceOrderModel(
      id: json['id'] as String? ?? '',
      laptopName: json['laptopName'] as String? ?? 'Laptop',
      serviceName: json['serviceName'] as String? ?? 'Servis',
      status: json['status'] as String? ?? 'Menunggu',
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      updatedAt: json['updatedAt'] as String? ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'laptopName': laptopName,
      'serviceName': serviceName,
      'status': status,
      'progress': progress,
      'updatedAt': updatedAt,
    };
  }
}
