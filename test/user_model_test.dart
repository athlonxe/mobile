import 'package:api_tester/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    test('fromJson menggunakan nilai fallback saat data API tidak lengkap', () {
      final user = UserModel.fromJson({'name': 'Budi Santoso', 'age': 22});

      expect(user.id, '');
      expect(user.name, 'Budi Santoso');
      expect(user.email, isNull);
      expect(user.age, 22);
      expect(user.isActive, isFalse);
    });

    test('toJson mengembalikan seluruh properti model', () {
      const user = UserModel(
        id: 'USR-001',
        name: 'Budi Santoso',
        email: 'budi@example.com',
        age: 22,
        isActive: true,
      );

      expect(user.toJson(), {
        'id': 'USR-001',
        'name': 'Budi Santoso',
        'email': 'budi@example.com',
        'age': 22,
        'isActive': true,
      });
    });
  });
}
