# API Tester - Tugas #2 dan #3 Mobile Developer

Proyek Flutter ini berisi aplikasi REST API tester, implementasi model data
`UserModel` untuk Tugas #2, serta UI modular untuk Tugas #3 Mobile Developer.

## Implementasi tugas

Model tersedia di `lib/user_model.dart` dan menerapkan:

- null safety dengan properti wajib dan opsional;
- constructor dengan named parameters;
- `factory UserModel.fromJson(Map<String, dynamic> json)`;
- `Map<String, dynamic> toJson()`;
- fallback aman ketika respons API tidak lengkap (`id`, `name`, `age`, atau
  `isActive` tidak dikirim).

Pengujian otomatisnya ada di `test/user_model_test.dart`.

## Implementasi Tugas #3

Antarmuka API Tester dipecah menjadi komponen yang dapat dipakai ulang:

- `lib/screens/api_tester_screen.dart`: halaman utama dan logika request HTTP;
- `lib/widgets/api_tester_header.dart`: header dengan `Stack` dan
  `Positioned` untuk kartu petunjuk yang bertumpuk;
- `lib/widgets/request_form_card.dart`: form request dan tampilan response;
- `lib/widgets/request_history_card.dart`: kartu riwayat request;
- `lib/models/request_log.dart`: model data riwayat request.

Riwayat berisi data dummy dan dirender melalui `ListView.builder`, sehingga
item dibuat secara lazy saat pengguna menggulir. Setelah request berhasil,
riwayat request baru otomatis ditambahkan di urutan teratas.

## Menjalankan proyek

```bash
flutter test
flutter run
```
