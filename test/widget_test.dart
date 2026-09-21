import 'package:api_tester/main.dart';
import 'package:api_tester/screens/fixmate_home_screen.dart';
import 'package:api_tester/screens/service_detail_screen.dart';
import 'package:api_tester/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('beranda stateless menampilkan tepat tiga kartu layanan', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const FixMateApp());

    expect(const FixMateHomeScreen(), isA<StatelessWidget>());
    expect(find.text('Halo, Timothy!'), findsOneWidget);
    expect(find.text('Layanan populer'), findsOneWidget);
    expect(find.byType(ServiceCard), findsNWidgets(3));
  });

  testWidgets('kartu membuka detail dan tombol memperbarui state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const FixMateApp());

    await tester.tap(find.text('Diagnosa Cepat'));
    await tester.pumpAndSettle();

    expect(find.byType(ServiceDetailScreen), findsOneWidget);
    expect(find.text('Detail Layanan'), findsOneWidget);
    expect(find.text('Booking Layanan'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    final initialColor = tester
        .widget<ElevatedButton>(find.byKey(const Key('booking-button')))
        .style
        ?.backgroundColor
        ?.resolve({});
    await tester.tap(find.byKey(const Key('booking-button')));
    await tester.pump();

    final bookedColor = tester
        .widget<ElevatedButton>(find.byKey(const Key('booking-button')))
        .style
        ?.backgroundColor
        ?.resolve({});
    expect(find.text('Booking Layanan'), findsNothing);
    expect(find.text('Layanan Dibooking'), findsOneWidget);
    expect(bookedColor, isNot(initialColor));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(FixMateHomeScreen), findsOneWidget);
  });
}
