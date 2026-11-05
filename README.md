# Tugas Sesi 5 - NusaEvent Hub

Aplikasi Flutter Material 3 untuk menemukan seminar dan workshop, melihat galeri serta denah venue, mendaftar tiket, dan membatalkan pendaftaran.

## Menjalankan

```sh
flutter pub get
flutter run
```

## Pengujian

```sh
flutter analyze
flutter test
```

## Struktur

- `lib/models/`: model `EventItem` dan `RegistrationTicket`.
- `lib/data/`: data contoh acara.
- `lib/widgets/`: kartu acara, filter kategori, dan denah interaktif.
- `lib/screens/`: daftar acara, galeri, formulir, dan tiket aktif.
- `screenshots/`: bukti tampilan perangkat dan Flutter DevTools yang tersedia.
- `Laporan_Praktikum_Tugas05.pdf`: laporan praktikum.

Tiket disimpan di memori selama aplikasi berjalan; penyimpanan backend belum menjadi bagian tugas ini.
