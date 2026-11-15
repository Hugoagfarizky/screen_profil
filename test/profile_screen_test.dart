import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:profil/main.dart';

void main() {
  // Pita teks dan lencana berputar terus, jadi tunggu animasi masuk
  // dengan durasi tetap (bukan pumpAndSettle).
  Future<void> buka(WidgetTester tester) async {
    tester.view.physicalSize = const Size(412, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
  }

  testWidgets('Bagian pembuka menampilkan nama, NRP, dan foto', (tester) async {
    await buka(tester);

    expect(
      find.textContaining('Muh Nugraha', findRichText: true),
      findsWidgets,
    );
    expect(find.textContaining('5051241034'), findsWidgets);
    expect(find.bySemanticsLabel(RegExp('^Foto Muh Nugraha')), findsOneWidget);
  });

  testWidgets('Baris Hobi bisa dibuka', (tester) async {
    await buka(tester);

    // "Badminton" juga ada di pita berjalan, jadi hitung pertambahannya.
    final sebelum = find.text('Badminton').evaluate().length;
    await tester.tap(find.text('Hobi & Minat'));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Badminton').evaluate().length, sebelum + 1);
  });

  testWidgets('Kontak tampil dan bisa disalin', (tester) async {
    await buka(tester);

    await tester.tap(find.text('@hugoagfarizky_'));
    await tester.pump();
    expect(find.textContaining('Instagram disalin'), findsOneWidget);
  });

  testWidgets('Tombol tandai di kartu pembuka bisa ditekan', (tester) async {
    await buka(tester);

    await tester.tap(find.byTooltip('Tandai profil'));
    await tester.pump();
    expect(find.text('Profil ditandai'), findsOneWidget);
    expect(find.byTooltip('Hapus tanda'), findsOneWidget);
  });

  testWidgets('Tombol bulan mengganti ke mode gelap', (tester) async {
    await buka(tester);

    await tester.tap(find.byTooltip('Mode gelap'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byTooltip('Mode terang'), findsOneWidget);
  });
}
