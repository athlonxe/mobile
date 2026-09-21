# FixMate

FixMate adalah aplikasi Flutter sederhana untuk melihat dan memilih layanan
servis laptop. Project ini saya buat untuk mengerjakan tugas Mobile Developer,
terutama materi routing, navigation, event, dan state.

## Fitur

- Menampilkan tiga pilihan layanan servis di halaman beranda.
- Setiap layanan bisa dibuka untuk melihat detail, harga, dan estimasi waktu.
- Berpindah dari halaman beranda ke detail menggunakan `Navigator.push`.
- Tombol kembali tersedia melalui `AppBar` pada halaman detail.
- Tombol booking berubah menjadi `Layanan Dibooking` setelah ditekan.
- Booking bisa dibatalkan dengan menekan tombol yang sama sekali lagi.

Halaman beranda dibuat menggunakan `StatelessWidget`, sedangkan halaman detail
menggunakan `StatefulWidget` karena ada perubahan status pada tombol booking.
Data layanan untuk sementara masih berupa data lokal yang ada di
`lib/data/fixmate_dummy_data.dart`.

## Cara menjalankan

Pastikan Flutter sudah terpasang. Setelah itu buka terminal di folder project
dan jalankan:

```bash
flutter pub get
flutter run
```

Untuk menjalankan pengujian:

```bash
flutter test
```

Project ini belum menggunakan backend atau database MySQL karena data layanan
masih disimpan langsung di dalam aplikasi.
