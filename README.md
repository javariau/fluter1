# First Flutter App

Aplikasi Counter PPM Sesi 1. Identitas mahasiswa dapat diubah di bagian konstanta pada `lib/main.dart` (`studentName`, `studentId`, dan `studyProgram`).

## Menyiapkan Android

Proyek ini menyimpan source aplikasi. Buat scaffold Android standar dengan Flutter CLI dari folder proyek:

```powershell
flutter create --platforms=android --project-name first_flutter_app android_scaffold
Copy-Item .\android_scaffold\android .\android -Recurse
Copy-Item .\android_scaffold\.metadata .\.metadata
Remove-Item .\android_scaffold -Recurse -Force
flutter pub get
flutter run
```

Sambungkan HP Android melalui USB, aktifkan **Opsi Pengembang** dan **USB debugging**, lalu izinkan komputer pada prompt di HP. Pastikan HP muncul saat menjalankan `adb devices -l`, kemudian jalankan `flutter run`.

Proyek ini menggunakan Flutter dan Material 3 tanpa package tambahan.
