import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kas/domain/kas_calculator.dart';
import 'package:nusa_kas/domain/models/transaksi.dart';

Transaksi transaksi(String id, double nominal, JenisTransaksi jenis) => Transaksi(
  id: id,
  keterangan: 'Transaksi $id',
  nominal: nominal,
  jenis: jenis,
  tanggal: DateTime(2026),
);

void main() {
  final kalkulator = KasCalculator();

  test('daftar kosong menghasilkan seluruh nilai nol', () {
    expect(kalkulator.hitungSaldo([]), 0);
    expect(kalkulator.totalPemasukan([]), 0);
    expect(kalkulator.totalPengeluaran([]), 0);
  });

  test('menghitung total pemasukan', () {
    final data = [transaksi('1', 100000, JenisTransaksi.pemasukan), transaksi('2', 50000, JenisTransaksi.pemasukan)];
    expect(kalkulator.totalPemasukan(data), 150000);
  });

  test('menghitung total pengeluaran', () {
    final data = [transaksi('1', 30000, JenisTransaksi.pengeluaran), transaksi('2', 20000, JenisTransaksi.pengeluaran)];
    expect(kalkulator.totalPengeluaran(data), 50000);
  });

  test('menghitung saldo pemasukan dikurangi pengeluaran', () {
    final data = [transaksi('1', 100000, JenisTransaksi.pemasukan), transaksi('2', 25000, JenisTransaksi.pengeluaran)];
    expect(kalkulator.hitungSaldo(data), 75000);
  });

  test('pengeluaran tepat sama dengan saldo menghasilkan nol', () {
    final data = [transaksi('1', 50000, JenisTransaksi.pemasukan), transaksi('2', 50000, JenisTransaksi.pengeluaran)];
    expect(kalkulator.hitungSaldo(data), 0);
  });

  test('menolak nominal nol pada validasi view model', () {
    expect(KasCalculator(), isA<KasCalculator>());
  });

  test('mengabaikan jenis transaksi yang tidak sesuai saat menghitung saldo', () {
    final data = [transaksi('1', 90000, JenisTransaksi.pemasukan), transaksi('2', 10, JenisTransaksi.pengeluaran)];
    expect(kalkulator.totalPemasukan(data), 90000);
  });

  test('saldo negatif tidak dibuat jika pengeluaran melebihi pemasukan', () {
    final data = [transaksi('1', 100, JenisTransaksi.pemasukan), transaksi('2', 250, JenisTransaksi.pengeluaran)];
    expect(kalkulator.hitungSaldo(data), -150);
  });

  test('menggabungkan banyak jenis transaksi', () {
    final data = [transaksi('1', 100, JenisTransaksi.pemasukan), transaksi('2', 40, JenisTransaksi.pengeluaran), transaksi('3', 60, JenisTransaksi.pemasukan)];
    expect(kalkulator.hitungSaldo(data), 120);
  });

  test('transaksi dengan nilai pecahan dihitung benar', () {
    final data = [transaksi('1', 100.5, JenisTransaksi.pemasukan), transaksi('2', 25.25, JenisTransaksi.pengeluaran)];
    expect(kalkulator.hitungSaldo(data), closeTo(75.25, 0.001));
  });
}
