import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readease/features/reader/highlight_dialog.dart';

void main() {
  group('HighlightDialog', () {
    testWidgets('creates highlight with note and color', (tester) async {
      String? savedNote;
      String? savedExcerpt;
      String? savedColor;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HighlightDialog(
            initialNote: 'Initial note',
            initialExcerpt: 'Selected text',
            initialColor: 'yellow',
            onSave: (note, excerpt, color) {
              savedNote = note;
              savedExcerpt = excerpt;
              savedColor = color;
            },
          ),
        ),
      ));

      // Verify initial state
      expect(find.text('Initial note'), findsOneWidget);
      expect(find.text('Selected text'), findsOneWidget);

      // Edit note
      await tester.enterText(
        find.widgetWithText(TextField, 'Note'),
        'Updated note',
      );

      // Edit excerpt
      await tester.enterText(
        find.widgetWithText(TextField, 'Excerpt'),
        'Updated text',
      );

      // Change color to green
      await tester.tap(find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Colors.green));
      await tester.pump();

      // Save changes
      await tester.tap(find.text('Save'));
      await tester.pump();

      // Verify callback values
      expect(savedNote, 'Updated note');
      expect(savedExcerpt, 'Updated text');
      expect(savedColor, 'green');
    });

    testWidgets('handles empty fields', (tester) async {
      String? savedNote;
      String? savedExcerpt;
      String? savedColor;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HighlightDialog(
            onSave: (note, excerpt, color) {
              savedNote = note;
              savedExcerpt = excerpt;
              savedColor = color;
            },
          ),
        ),
      ));

      // Default color should be yellow
      await tester.tap(find.text('Save'));
      await tester.pump();

      expect(savedNote, '');
      expect(savedExcerpt, '');
      expect(savedColor, 'yellow');
    });

    testWidgets('can be cancelled', (tester) async {
      bool dialogClosed = false;

      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                await showDialog<void>(
                  context: context,
                  builder: (context) => HighlightDialog(
                    onSave: (_, __, ___) {},
                  ),
                );
                dialogClosed = true;
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      ));

      // Open dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Tap cancel
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(dialogClosed, true);
    });
  });
}
