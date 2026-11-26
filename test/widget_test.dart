// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:landchain/app.dart';
import 'package:landchain/config/dependencies.dart';

void main() {
  testWidgets('LandChain displays the home screen and navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LandChainDependencies(child: LandChainApp()));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('LANDCHAIN'), findsOneWidget);
    expect(find.text('Data Tanah'), findsOneWidget);
    expect(find.text('Checklist'), findsOneWidget);
    expect(find.text('Blockchain'), findsOneWidget);
  });

  testWidgets(
    'captures submission screenshots for each tab and checklist change',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(430, 932);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const LandChainDependencies(child: LandChainApp()),
      );
      await tester.pump(const Duration(milliseconds: 650));
      await tester.pump();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('screenshots/home-before.png'),
      );

      await tester.tap(find.text('Data Tanah'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('screenshots/land-list.png'),
      );

      await tester.tap(find.text('Checklist'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 550));
      await tester.pump();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('screenshots/checklist.png'),
      );

      await tester.tap(find.byType(CheckboxListTile).first);
      await tester.pump();
      await tester.tap(find.text('Beranda'));
      await tester.pump();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('screenshots/home-after.png'),
      );

      await tester.tap(find.text('Blockchain'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('screenshots/blockchain.png'),
      );
    },
  );
}
