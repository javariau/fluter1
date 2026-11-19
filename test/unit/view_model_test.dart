import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kas/data/repositories/transaksi_repository.dart';
import 'package:nusa_kas/domain/models/transaksi.dart';
import 'package:nusa_kas/ui/kas/kas_view_model.dart';

void main() {
  test('menolak nominal nol dan negatif', () {
    final vm = KasViewModel(repository: TransaksiRepository());
    expect(vm.validasiTransaksi(0, JenisTransaksi.pemasukan), 'Nominal harus lebih dari nol');
    expect(vm.validasiTransaksi(-10, JenisTransaksi.pemasukan), 'Nominal harus lebih dari nol');
  });

  test('menolak pengeluaran melebihi saldo', () {
    final vm = KasViewModel(repository: TransaksiRepository());
    vm.tambahTransaksi(keterangan: 'Iuran', nominal: 100, jenis: JenisTransaksi.pemasukan);
    expect(vm.validasiTransaksi(101, JenisTransaksi.pengeluaran), 'Pengeluaran melebihi saldo');
  });

  test('mengizinkan pengeluaran tepat sama dengan saldo', () {
    final vm = KasViewModel(repository: TransaksiRepository());
    vm.tambahTransaksi(keterangan: 'Iuran', nominal: 100, jenis: JenisTransaksi.pemasukan);
    expect(vm.validasiTransaksi(100, JenisTransaksi.pengeluaran), isNull);
  });
}
