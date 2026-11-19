import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kas/data/repositories/transaksi_repository.dart';
import 'package:nusa_kas/ui/kas/kas_view_model.dart';
import 'package:nusa_kas/ui/kas/tambah_transaksi_screen.dart';

Widget app(KasViewModel vm) => MaterialApp(home: TambahTransaksiScreen(viewModel: vm));

void main() {
  testWidgets('menampilkan validasi keterangan dan nominal', (tester) async {
    final vm = KasViewModel(repository: TransaksiRepository());
    await tester.pumpWidget(app(vm));
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pump();
    expect(find.text('Keterangan wajib diisi'), findsOneWidget);
    expect(find.text('Nominal wajib diisi'), findsOneWidget);
  });

  testWidgets('menambah pemasukan dan menutup halaman', (tester) async {
    final vm = KasViewModel(repository: TransaksiRepository());
    await tester.pumpWidget(app(vm));
    await tester.enterText(find.byKey(const Key('field_keterangan')), 'Iuran anggota');
    await tester.enterText(find.byKey(const Key('field_nominal')), '250000');
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pumpAndSettle();
    expect(vm.saldo, 250000);
    expect(vm.transaksi.length, 1);
  });
}
