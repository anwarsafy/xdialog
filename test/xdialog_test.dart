import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xdialog/xdialog.dart';

void main() {
  group('XDialog Tests', () {
    testWidgets('Dialog displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: TextButton(
                onPressed: () => XDialog.show(
                  context: context,
                  title: 'Test Title',
                  message: 'Test Message',
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);
    });

    testWidgets('Dialog with buttons displays correctly',
            (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => Center(
                  child: TextButton(
                    onPressed: () => XDialog.show(
                      context: context,
                      title: 'Buttons Test',
                      message: 'Testing buttons',
                      positiveButtonText: 'OK',
                      negativeButtonText: 'Cancel',
                      neutralButtonText: 'More Info',
                    ),
                    child: const Text('Show Dialog'),
                  ),
                ),
              ),
            ),
          ));

          await tester.tap(find.text('Show Dialog'));
          await tester.pumpAndSettle();

          expect(find.text('OK'), findsOneWidget);
          expect(find.text('Cancel'), findsOneWidget);
          expect(find.text('More Info'), findsOneWidget);
        });

    testWidgets('Dialog with custom icon displays correctly',
            (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => Center(
                  child: TextButton(
                    onPressed: () => XDialog.show(
                      context: context,
                      title: 'Icon Test',
                      message: 'Testing custom icon',
                      icon: const Icon(Icons.warning, color: Colors.red),
                    ),
                    child: const Text('Show Dialog'),
                  ),
                ),
              ),
            ),
          ));

          await tester.tap(find.text('Show Dialog'));
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.warning), findsOneWidget);
        });

    testWidgets('Dialog close button works', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: TextButton(
                onPressed: () => XDialog.show(
                  context: context,
                  title: 'Close Test',
                  message: 'Testing close button',
                  showCloseIcon: true,
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Close Test'), findsNothing);
    });

    testWidgets('Button press callbacks work', (WidgetTester tester) async {
      bool positivePressed = false;
      bool negativePressed = false;
      bool neutralPressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: TextButton(
                onPressed: () => XDialog.show(
                  context: context,
                  title: 'Callbacks Test',
                  message: 'Testing button callbacks',
                  positiveButtonText: 'OK',
                  negativeButtonText: 'Cancel',
                  neutralButtonText: 'Info',
                  onPositivePressed: () => positivePressed = true,
                  onNegativePressed: () => negativePressed = true,
                  onNeutralPressed: () => neutralPressed = true,
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      expect(positivePressed, isTrue);

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      expect(negativePressed, isTrue);

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Info'));
      expect(neutralPressed, isTrue);
    });

    testWidgets('Default styling works', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: TextButton(
                onPressed: () => XDialog.show(
                  context: context,
                  title: 'Style Test',
                  message: 'Testing default styling',
                  positiveButtonText: 'OK',
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify default icon exists
      expect(find.byIcon(Icons.info_outline), findsOneWidget);

      // Verify default button color
      final okButton = tester.widget<Text>(find.text('OK'));
      expect(okButton.style?.color, Colors.white);
    });
  });
}