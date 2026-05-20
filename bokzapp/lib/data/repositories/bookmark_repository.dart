import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readease/core/result.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/db/providers.dart';
import 'package:uuid/uuid.dart';

class BookmarkRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  BookmarkRepository(this._db);

  Stream<List<Bookmark>> watchBookmarks(String bookId) {
    return (_db.select(_db.bookmarks)
          ..where((b) => b.bookId.equals(bookId))
          ..orderBy([(b) => OrderingTerm(expression: b.createdAt)]))
        .watch();
  }

  Future<Result<List<Bookmark>>> getBookmarks(String bookId) async {
    try {
      final bookmarks = await (_db.select(_db.bookmarks)
            ..where((b) => b.bookId.equals(bookId)))
          .get();
      return Success(bookmarks);
    } catch (e) {
      return Failure(AppError('Failed to get bookmarks: $e'));
    }
  }

  Future<Result<String>> addBookmark({
    required String bookId,
    String? cfi,
    int? page,
    int? audioSec,
    String? note,
    String? color,
  }) async {
    try {
      final id = _uuid.v4();
      await _db.into(_db.bookmarks).insert(
            BookmarksCompanion.insert(
              id: id,
              bookId: bookId,
              cfi: Value(cfi),
              page: Value(page),
              audioSec: Value(audioSec),
              note: Value(note),
              color: Value(color),
              createdAt: DateTime.now(),
            ),
          );
      return Success(id);
    } catch (e) {
      return Failure(AppError('Failed to add bookmark: $e'));
    }
  }

  Future<Result<void>> updateBookmark({
    required String id,
    String? note,
    String? color,
  }) async {
    try {
      await (_db.update(_db.bookmarks)..where((b) => b.id.equals(id))).write(
        BookmarksCompanion(
          note: Value(note),
          color: Value(color),
        ),
      );
      return const Success(null);
    } catch (e) {
      return Failure(AppError('Failed to update bookmark: $e'));
    }
  }

  Future<Result<void>> deleteBookmark(String id) async {
    try {
      await (_db.delete(_db.bookmarks)..where((b) => b.id.equals(id))).go();
      return const Success(null);
    } catch (e) {
      return Failure(AppError('Failed to delete bookmark: $e'));
    }
  }
}

final bookmarkRepositoryProvider = Provider<BookmarkRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return BookmarkRepository(db);
});
