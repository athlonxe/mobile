/// Model data pengguna yang merepresentasikan respons API.
///
/// Field [email] bersifat opsional karena API dapat tidak mengirimkannya,
/// sedangkan field lain selalu memiliki nilai aman melalui [fromJson].
class UserModel {
  final String id;
  final String name;
  final String? email;
  final int age;
  final bool isActive;

  const UserModel({
    required this.id,
    required this.name,
    this.email,
    required this.age,
    required this.isActive,
  });

  /// Mengonversi data JSON dari API menjadi objek Dart yang null-safe.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown User',
      email: json['email'] as String?,
      age: json['age'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? false,
    );
  }

  /// Mengonversi objek Dart kembali ke format JSON untuk dikirim ke API.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'isActive': isActive,
    };
  }
}
