# API Tester - Tugas #2 Mobile Developer

Proyek Flutter ini berisi aplikasi REST API tester dan implementasi model data
`UserModel` sesuai Tugas #2 Mobile Developer.

## Implementasi tugas

Model tersedia di `lib/user_model.dart` dan menerapkan:

- null safety dengan properti wajib dan opsional;
- constructor dengan named parameters;
- `factory UserModel.fromJson(Map<String, dynamic> json)`;
- `Map<String, dynamic> toJson()`;
- fallback aman ketika respons API tidak lengkap (`id`, `name`, `age`, atau
  `isActive` tidak dikirim).

Pengujian otomatisnya ada di `test/user_model_test.dart`.

## Menjalankan proyek

```bash
flutter test
flutter run
```
