import 'package:flutter/material.dart';

// Fungsi utama yang dijalankan pertama kali saat aplikasi dibuka.
void main() {
  runApp(const MyApp());
}

// Widget utama yang menjadi akar aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Fungsi untuk menyusun tampilan aplikasi.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Judul aplikasi.
      title: 'Flutter Demo',

      // Mengatur tema atau tampilan umum aplikasi.
      theme: ThemeData(
        // Coba jalankan aplikasi menggunakan perintah "flutter run".
        // Kamu akan melihat bilah aplikasi dengan warna ungu.
        //
        // Tanpa menghentikan aplikasi, coba ganti seedColor di bawah
        // menjadi Colors.green, lalu lakukan Hot Reload.
        // Kamu bisa menyimpan kode atau menekan tombol Hot Reload
        // di editor yang mendukung Flutter.
        // Jika menjalankan melalui terminal, tekan tombol "r".
        //
        // Perhatikan bahwa angka penghitung tidak kembali ke nol
        // setelah Hot Reload karena keadaan aplikasi tetap tersimpan.
        // Untuk memulai ulang keadaan aplikasi dari awal, gunakan
        // Hot Restart.
        //
        // Perubahan kode juga umumnya bisa langsung diuji dengan
        // Hot Reload tanpa perlu menghentikan aplikasi.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),

      // Menentukan halaman pertama yang ditampilkan.
      home: const MyHomePage(
        title: 'javariaubintang muharram 20240040219',
      ), //////////////////////////
    );
  }
}

// Widget halaman utama aplikasi.
// StatefulWidget digunakan ketika data pada halaman dapat berubah.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Kelas ini menyimpan pengaturan atau informasi halaman.
  // Nilai yang diberikan dari widget induk akan digunakan
  // oleh fungsi build untuk menampilkan halaman.
  //
  // Properti pada kelas turunan Widget biasanya dibuat final
  // agar nilainya tidak dapat diubah setelah ditentukan.

  // Variabel untuk menyimpan judul halaman.
  final String title;

  @override
  // Membuat objek State untuk mengelola perubahan halaman.
  State<MyHomePage> createState() => _MyHomePageState();
}

// Kelas yang menyimpan data dan mengatur perubahan tampilan.
class _MyHomePageState extends State<MyHomePage> {
  // Menyimpan angka penghitung dengan nilai awal 0.
  int _counter = 0;

  // Fungsi untuk menambah angka penghitung.
  void _incrementCounter() {
    setState(() {
      // setState memberi tahu Flutter bahwa ada data yang berubah.
      // Flutter kemudian menjalankan kembali fungsi build
      // agar tampilan menampilkan nilai terbaru.
      //
      // Jika nilai _counter diubah tanpa setState,
      // perubahan tersebut tidak langsung ditampilkan di layar.
      _counter++;
    });
  }

  // Fungsi untuk mengurangi angka
  void _decrementCounter() {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      }
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fungsi build dijalankan kembali setiap kali setState dipanggil,
    // misalnya setelah tombol tambah ditekan.
    //
    // Flutter dirancang agar proses menyusun ulang tampilan
    // berlangsung cepat. Karena itu, kita tidak perlu mengubah
    // setiap bagian tampilan secara manual satu per satu.
    return Scaffold(
      // Bilah bagian atas aplikasi.
      appBar: AppBar(
        // Mengatur warna bilah aplikasi menggunakan warna dari tema.
        // Coba ganti warna ini menjadi Colors.amber, lalu simpan kode.
        // Warna bilah aplikasi akan berubah, sedangkan warna lainnya
        // tetap mengikuti pengaturan tema.
        backgroundColor: Theme.of(context)
            .colorScheme
            .inversePrimary, //////////////
        // Menampilkan judul yang diberikan oleh MyHomePage
        // melalui properti title.
        title: Text(widget.title),
      ),

      // Bagian utama halaman aplikasi.
      body: Center(
        // Center adalah widget tata letak yang menempatkan
        // satu widget anak di bagian tengah.
        child: Column(
          // Column menyusun beberapa widget secara vertikal.
          // Secara bawaan, lebarnya mengikuti kebutuhan isi,
          // sedangkan tingginya mengikuti ruang yang tersedia.
          //
          // mainAxisAlignment mengatur posisi widget pada
          // arah utama Column, yaitu arah vertikal.
          // Nilai center membuat semua isi berada di tengah.
          //
          // Untuk melihat batas setiap widget, kamu bisa mencoba
          // fitur Debug Paint di editor atau menekan tombol "p"
          // pada terminal saat aplikasi sedang berjalan.
          mainAxisAlignment: .center,

          // Daftar widget yang ditampilkan di dalam Column.
          children: [
            // Menampilkan teks petunjuk penghitung.
            const Text('You have pushed the button this many times:'),

            // Menampilkan angka penghitung yang tersimpan.
            Text(
              '$_counter',

              // Menggunakan ukuran dan gaya teks dari tema aplikasi.
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      // Tombol melayang yang berada di bagian bawah halaman.
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tombol kurang
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Kurang',
            child: const Icon(Icons.remove),
          ),

          const SizedBox(width: 10),

          // Tombol tambah
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Tambah',
            child: const Icon(Icons.add),
          ),

          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _reset,
            tooltip: 'ulang',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
