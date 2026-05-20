import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readease/core/result.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/repositories/highlight_repository.dart';

void main() {
  late AppDatabase db;
  late HighlightRepository repository;

  setUp(() {
    db = AppDatabase.withConnection(NativeDatabase.memory());
    repository = HighlightRepository(db);
    // Insert a minimal book so FK constraints for highlights/pass
    db.into(db.books).insert(BooksCompanion.insert(
          id: 'book-123',
          path: '/tmp/book.epub',
          hash: 'h',
          title: 'Test Book',
          author: 'Author',
          tags: '[]',
          type: BookType.epub,
          coverPath: const Value(null),
          durationSec: const Value(null),
          pageCount: const Value(10),
          addedAt: DateTime.now(),
          lastOpenedAt: DateTime.now(),
        ));
  });

  tearDown(() async {
    await db.close();
  });

  group('HighlightRepository', () {
    final testBookId = 'book-123';

    test('addHighlight creates a new highlight', () async {
      final result = await repository.addHighlight(
        bookId: testBookId,
        page: 1,
        positionFraction: 0.5,
        excerpt: 'Test excerpt',
        note: 'Test note',
        color: 'yellow',
      );

      expect(result, isA<Success<String>>());
      final id = (result as Success<String>).value;
      expect(id, isNotEmpty);

      final highlights = await repository.getHighlights(testBookId);
      expect(highlights, isA<Success<List<Highlight>>>());

      final list = (highlights as Success<List<Highlight>>).value;
      expect(list.length, 1);
      expect(list.first.bookId, testBookId);
      expect(list.first.page, 1);
      expect(list.first.positionFraction, 5000); // 0.5 * 10000
      expect(list.first.excerpt, 'Test excerpt');
      expect(list.first.note, 'Test note');
      expect(list.first.color, 'yellow');
    });

    test('watchHighlights emits updates', () async {
      // Add initial highlight
      final result = await repository.addHighlight(
        bookId: testBookId,
        page: 1,
        note: 'Initial note',
      );
      final id = (result as Success<String>).value;

      // Set up the stream
      final highlights = repository.watchHighlights(testBookId);

      // Verify initial state
      var first = await highlights.first;
      expect(first.length, 1);
      expect(first.first.note, 'Initial note');

      // Add another highlight
      await repository.addHighlight(
        bookId: testBookId,
        page: 2,
        note: 'Second note',
      );

      // Verify stream updates
      final updated = await highlights.first;
      expect(updated.length, 2);
      expect(updated.map((h) => h.note), contains('Second note'));

      // Delete a highlight
      await repository.deleteHighlight(id);

      // Verify deletion reflected in stream
      final afterDelete = await highlights.first;
      expect(afterDelete.length, 1);
      expect(afterDelete.first.note, 'Second note');
    });

    test('deleteHighlight removes highlight', () async {
      // Add a highlight
      final result = await repository.addHighlight(
        bookId: testBookId,
        page: 1,
      );
      final id = (result as Success<String>).value;

      // Delete it
      final deleteResult = await repository.deleteHighlight(id);
      expect(deleteResult, isA<Success<void>>());

      // Verify it's gone
      final highlights = await repository.getHighlights(testBookId);
      final list = (highlights as Success<List<Highlight>>).value;
      expect(list, isEmpty);
    });
  });
}
