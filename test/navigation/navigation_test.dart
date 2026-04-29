import 'package:flutter/material.dart';
import 'package:flutter_pemula_project/view/detail_page.dart';
import 'package:flutter_pemula_project/model/google_office.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Navigation to DetailPage', () {
    testWidgets('pushes DetailPage with googleOffice', (
      WidgetTester tester,
    ) async {
      final office = listOfGoogleOffice.first;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailPage(googleOffice: office),
                  ),
                );
              },
              child: const Text('Go'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      final detailPage = tester.widget<DetailPage>(find.byType(DetailPage));
      expect(detailPage.googleOffice, equals(office));
      expect(detailPage.googleOfficeId, isNull);
    });

    testWidgets('pushes DetailPage with googleOfficeId', (
      WidgetTester tester,
    ) async {
      const officeId = 'jakarta';

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailPage(googleOfficeId: officeId),
                  ),
                );
              },
              child: const Text('Go'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      final detailPage = tester.widget<DetailPage>(find.byType(DetailPage));
      expect(detailPage.googleOffice, isNull);
      expect(detailPage.googleOfficeId, equals(officeId));
    });

    testWidgets('DetailPage resolves correct office from googleOfficeId', (
      WidgetTester tester,
    ) async {
      const officeId = 'jakarta';

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailPage(googleOfficeId: officeId),
                  ),
                );
              },
              child: const Text('Go'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      final detailPage = tester.widget<DetailPage>(find.byType(DetailPage));
      final expectedOffice = listOfGoogleOffice.firstWhere(
        (e) => e.id == officeId,
      );
      expect(detailPage.office, equals(expectedOffice));
    });

    testWidgets('pops back from DetailPage', (WidgetTester tester) async {
      final office = listOfGoogleOffice.first;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailPage(googleOffice: office),
                  ),
                );
              },
              child: const Text('Go'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      expect(find.byType(DetailPage), findsOneWidget);

      Navigator.of(tester.element(find.byType(DetailPage))).pop();
      await tester.pumpAndSettle();

      expect(find.byType(DetailPage), findsNothing);
    });
  });
}
