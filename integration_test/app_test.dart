import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nusa_kas/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('menambah dua transaksi lalu memeriksa saldo', (tester) async {
    await tester.pumpWidget(const NusaKasApp());

    await tester.tap(find.byKey(const Key('tombol_tambah')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('field_keterangan')), 'Iuran bulanan');
    await tester.enterText(find.byKey(const Key('field_nominal')), '500000');
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('tombol_tambah')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('field_keterangan')), 'Beli ATK');
    await tester.enterText(find.byKey(const Key('field_nominal')), '125000');
    await tester.tap(find.byKey(const Key('field_jenis')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pengeluaran').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pumpAndSettle();

    expect(find.textContaining('Rp 375.000'), findsWidgets);
    expect(find.text('Iuran bulanan'), findsOneWidget);
    expect(find.text('Beli ATK'), findsOneWidget);
  });
}
