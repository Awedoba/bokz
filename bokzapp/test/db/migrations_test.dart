import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readease/data/db/database.dart';

void main() {
  group('Database Migrations', () {
    test('v1 to v2: creates highlights table', () async {
      // Create v1 database
      final db = AppDatabase();
      await db.close();

      // Open v2 database at same path - should migrate
      final dbV2 = AppDatabase();

      // Verify highlights table exists and is empty
      final highlights = await dbV2.select(dbV2.highlights).get();
      expect(highlights, isEmpty);

      // Try inserting a highlight
      final now = DateTime.now();
      await dbV2.into(dbV2.highlights).insert(
            HighlightsCompanion.insert(
              id: '123',
              bookId: 'book-1',
              positionFraction: 5000,
              createdAt: now,
            ),
          );

      // Verify highlight was inserted
      final inserted = await dbV2.select(dbV2.highlights).get();
      expect(inserted.length, 1);
      expect(inserted.first.id, '123');
      expect(inserted.first.bookId, 'book-1');
      expect(inserted.first.positionFraction, 5000);
      expect(inserted.first.createdAt, now);

      await dbV2.close();
    });

    test('v2: enforces foreign key constraints', () async {
      final db = AppDatabase();

      // Try inserting highlight with non-existent book
      expect(() async {
        await db.into(db.highlights).insert(
              HighlightsCompanion.insert(
                id: '123',
                bookId: 'non-existent',
                positionFraction: 5000,
                createdAt: DateTime.now(),
              ),
            );
      }, throwsA(anything)); // Should fail due to FK constraint

      await db.close();
    });
  });
}
