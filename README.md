# LandChain

LandChain adalah aplikasi administrasi dokumen pertanahan dengan simulasi pencatatan transaksi bergaya blockchain. Tema ini dipilih karena proses pengurusan tanah memiliki data dokumen yang terstruktur, tahapan yang dapat dicentang, dan riwayat verifikasi yang cocok dipantau melalui satu aplikasi. Seluruh transaksi pada versi tugas ini menggunakan data dummy dan tidak terhubung ke blockchain sungguhan.

## Pemetaan Data

| Jenis data tugas | Model                 | Isi                                                                                      |
| ---------------- | --------------------- | ---------------------------------------------------------------------------------------- |
| Data utama       | `LandModel`           | Bidang tanah, pemilik, lokasi, luas, kategori sertifikat, status, dan tanggal penerbitan |
| Data aksi        | `TaskModel`           | Checklist tahapan administrasi dengan status selesai/belum selesai                       |
| Data informasi   | `BlockchainInfoModel` | Riwayat perubahan dokumen dan hash transaksi simulasi                                    |

## Fitur Buatan Sendiri

Blockchain Explorer menampilkan riwayat perubahan dokumen dalam bentuk timeline, lengkap dengan transaction hash, tanggal, status konfirmasi, dan deskripsi. Data ditampilkan dari repository terpisah dan seluruhnya merupakan simulasi lokal.

## Arsitektur

Alur data mengikuti `Service -> Repository -> ViewModel -> View`. UI menggunakan Provider untuk dependency injection, ChangeNotifier untuk state, ListenableBuilder untuk pembaruan layar, dan Material Design 3.

## Menjalankan Aplikasi

```bash
flutter pub get
flutter run
```

## Screenshot Pengumpulan

Screenshot berikut dihasilkan oleh widget test pada viewport ponsel. Ambil juga screenshot dari emulator/HP saat menjalankan aplikasi untuk bukti penggunaan di perangkat.

| Tampilan                            | Screenshot                                          |
| ----------------------------------- | --------------------------------------------------- |
| Beranda sebelum checklist dicentang | [home-before.png](test/screenshots/home-before.png) |
| Beranda setelah checklist dicentang | [home-after.png](test/screenshots/home-after.png)   |
| Data Tanah                          | [land-list.png](test/screenshots/land-list.png)     |
| Checklist                           | [checklist.png](test/screenshots/checklist.png)     |
| Blockchain Explorer                 | [blockchain.png](test/screenshots/blockchain.png)   |

## Hasil Pengujian

Perintah: `flutter test`

Hasil lokal: `flutter test` lulus. Test mencakup pemuatan dan error BlockchainViewModel, navigasi aplikasi, serta snapshot tampilan.

## Pengumpulan

Upload repository ini ke GitHub dan cantumkan URL repository pada formulir pengumpulan. Pengumpulan dilakukan paling cepat pada hari UTS dan paling lambat satu minggu setelah UTS. Jika dikumpulkan tepat satu minggu setelah UTS, lampirkan video penjelasan aplikasi.
