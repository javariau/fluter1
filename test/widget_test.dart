import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_sesi_5/main.dart';

void main() {
  testWidgets('seminar home fits a narrow 255px window without overflow', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.physicalSize = const Size(255, 900);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const NusaEventApp());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('registration flow validates fields and supports ticket cancellation', (tester) async {
    await tester.pumpWidget(const NusaEventApp());

    expect(find.text('NusaEvent'), findsOneWidget);
    expect(find.text('Seminar & Workshop'), findsOneWidget);
    expect(find.text('Filter'), findsOneWidget);
    await tester.tap(find.text('Filter'));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(of: find.byType(BottomSheet), matching: find.text('AI')));
    await tester.pumpAndSettle();
    expect(find.text('AI for Everyone: Dari Prompt ke Produk'), findsOneWidget);
    expect(find.text('Connected Campus: IoT dari Sensor ke Cloud'), findsNothing);
    await tester.ensureVisible(find.text('AI for Everyone: Dari Prompt ke Produk'));
    await tester.tap(find.text('AI for Everyone: Dari Prompt ke Produk'));
    await tester.pumpAndSettle();
    expect(find.text('Formulir pendaftaran'), findsOneWidget);

    await tester.drag(find.byType(ListView).last, const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Daftar • Rp75k'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).last, const Offset(0, 500));
    await tester.pumpAndSettle();
    expect(find.text('Nama wajib diisi'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Dina Pratama');
    await tester.enterText(find.byType(TextFormField).at(1), '20240012345');
    await tester.enterText(find.byType(TextFormField).at(2), 'dina@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), '081234567890');
    await tester.drag(find.byType(ListView).last, const Offset(0, -450));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pilih tanggal kehadiran'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('PILIH'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).last, const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Saya menyetujui tata tertib acara'));
    await tester.drag(find.byType(ListView).last, const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Daftar • Rp75k'));
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tiket'));
    await tester.pumpAndSettle();
    expect(find.text('Dina Pratama'), findsOneWidget);
    await tester.drag(find.text('Dina Pratama'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Batalkan tiket?'), findsOneWidget);
    await tester.tap(find.text('Ya, batalkan'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada tiket aktif'), findsOneWidget);

    await tester.tap(find.text('Galeri & peta'));
    await tester.pumpAndSettle();
    expect(find.text('Galeri & Denah Venue'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Denah Gedung Nusa'), 350, scrollable: find.byType(Scrollable).last);
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
