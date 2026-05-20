import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readease/core/result.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/db/providers.dart';
import 'package:uuid/uuid.dart';

class HighlightRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  HighlightRepository(this._db);

  Stream<List<Highlight>> watchHighlights(String bookId) {
    return (_db.select(_db.highlights)
          ..where((h) => h.bookId.equals(bookId))
          ..orderBy([(h) => OrderingTerm(expression: h.createdAt)]))
        .watch();
  }

  Future<Result<List<Highlight>>> getHighlights(String bookId) async {
    try {
      final highlights = await (_db.select(_db.highlights)
            ..where((h) => h.bookId.equals(bookId)))
          .get();
      return Success(highlights);
    } catch (e) {
      return Failure(AppError('Failed to get highlights: $e'));
    }
  }

  Future<Result<String>> addHighlight({
    required String bookId,
    String? cfi,
    int? page,
    double? positionFraction,
    double? rectLeft,
    double? rectTop,
    double? rectWidth,
    double? rectHeight,
    String? excerpt,
    String? note,
    String? color,
  }) async {
    try {
      final id = _uuid.v4();
      await _db.into(_db.highlights).insert(
            HighlightsCompanion.insert(
              id: id,
              bookId: bookId,
              cfi: Value(cfi),
              page: Value(page),
              positionFraction: Value((positionFraction != null)
                  ? (positionFraction.clamp(0.0, 1.0) * 10000).toInt()
                  : 0),
              rectLeft: Value((rectLeft != null)
                  ? (rectLeft.clamp(0.0, 1.0) * 10000).toInt()
                  : 0),
              rectTop: Value((rectTop != null)
                  ? (rectTop.clamp(0.0, 1.0) * 10000).toInt()
                  : 0),
              rectWidth: Value((rectWidth != null)
                  ? (rectWidth.clamp(0.0, 1.0) * 10000).toInt()
                  : 0),
              rectHeight: Value((rectHeight != null)
                  ? (rectHeight.clamp(0.0, 1.0) * 10000).toInt()
                  : 0),
              excerpt: Value(excerpt),
              note: Value(note),
              color: Value(color),
              createdAt: DateTime.now(),
            ),
          );
      return Success(id);
    } catch (e) {
      return Failure(AppError('Failed to add highlight: $e'));
    }
  }

  Future<Result<void>> deleteHighlight(String id) async {
    try {
      await (_db.delete(_db.highlights)..where((h) => h.id.equals(id))).go();
      return const Success(null);
    } catch (e) {
      return Failure(AppError('Failed to delete highlight: $e'));
    }
  }

  Future<Result<void>> updateHighlight({
    required String id,
    String? excerpt,
    String? note,
    String? color,
  }) async {
    try {
      await (_db.update(_db.highlights)..where((h) => h.id.equals(id))).write(
        HighlightsCompanion(
          excerpt: Value(excerpt),
          note: Value(note),
          color: Value(color),
        ),
      );
      return const Success(null);
    } catch (e) {
      return Failure(AppError('Failed to update highlight: $e'));
    }
  }
}

final highlightRepositoryProvider = Provider<HighlightRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return HighlightRepository(db);
});
