import 'package:drift/drift.dart';
import 'package:readease/core/result.dart';
import 'package:readease/data/db/database.dart';

abstract class BookRepository {
  Future<Result<Book>> getBook(String id);
  Future<Result<List<Book>>> searchBooks(String query);
  Future<Result<void>> saveBook(Book book);
  Future<Result<List<Book>>> getRecentBooks();
  Stream<List<Book>> watchRecentBooks();
  Future<Result<void>> updateReadingPosition(
      String bookId, ReadingPosition position);
  Future<Result<ReadingPosition?>> getReadingPosition(String bookId);
  Future<Result<void>> addBookmark(Bookmark bookmark);
  Future<Result<List<Bookmark>>> getBookmarks(String bookId);
}

class DriftBookRepository implements BookRepository {
  final AppDatabase _db;

  DriftBookRepository(this._db);

  @override
  Future<Result<Book>> getBook(String id) async {
    try {
      final book = await (_db.select(_db.books)..where((b) => b.id.equals(id)))
          .getSingle();
      return Success(book);
    } catch (e) {
      return Failure(AppError('Failed to get book: $e'));
    }
  }

  @override
  Future<Result<List<Book>>> searchBooks(String query) async {
    try {
      final books = await (_db.select(_db.books)
            ..where(
                (b) => b.title.like('%$query%') | b.author.like('%$query%')))
          .get();
      return Success(books);
    } catch (e) {
      return Failure(AppError('Failed to search books: $e'));
    }
  }

  @override
  Future<Result<void>> saveBook(Book book) async {
    try {
      await _db.into(_db.books).insert(book);
      return const Success(null);
    } catch (e) {
      return Failure(AppError('Failed to save book: $e'));
    }
  }

  @override
  Future<Result<List<Book>>> getRecentBooks() async {
    try {
      final books = await (_db.select(_db.books)
            ..orderBy([
              (b) => OrderingTerm(
                  expression: b.lastOpenedAt, mode: OrderingMode.desc)
            ])
            ..limit(10))
          .get();
      return Success(books);
    } catch (e) {
      return Failure(AppError('Failed to get recent books: $e'));
    }
  }

  @override
  Stream<List<Book>> watchRecentBooks() {
    return (_db.select(_db.books)
          ..orderBy([
            (b) => OrderingTerm(
                expression: b.lastOpenedAt, mode: OrderingMode.desc)
          ])
          ..limit(10))
        .watch();
  }

  @override
  Future<Result<void>> updateReadingPosition(
      String bookId, ReadingPosition position) async {
    try {
      await _db.into(_db.readingPositions).insertOnConflictUpdate(position);
      return const Success(null);
    } catch (e) {
      return Failure(AppError('Failed to update reading position: $e'));
    }
  }

  @override
  Future<Result<ReadingPosition?>> getReadingPosition(String bookId) async {
    try {
      final position = await (_db.select(_db.readingPositions)
            ..where((p) => p.bookId.equals(bookId))
            ..orderBy([
              (p) =>
                  OrderingTerm(expression: p.updatedAt, mode: OrderingMode.desc)
            ])
            ..limit(1))
          .getSingleOrNull();
      return Success(position);
    } catch (e) {
      return Failure(AppError('Failed to get reading position: $e'));
    }
  }

  @override
  Future<Result<void>> addBookmark(Bookmark bookmark) async {
    try {
      await _db.into(_db.bookmarks).insert(bookmark);
      return const Success(null);
    } catch (e) {
      return Failure(AppError('Failed to add bookmark: $e'));
    }
  }

  @override
  Future<Result<List<Bookmark>>> getBookmarks(String bookId) async {
    try {
      // First get the book type
      final book = await (_db.select(_db.books)
            ..where((b) => b.id.equals(bookId)))
          .getSingle();

      final query = _db.select(_db.bookmarks)
        ..where((b) => b.bookId.equals(bookId));

      // Order based on book type
      switch (book.type) {
        case BookType.pdf:
          query.orderBy([(b) => OrderingTerm(expression: b.page)]);
        case BookType.epub:
          query.orderBy([(b) => OrderingTerm(expression: b.cfi)]);
        case BookType.audio:
          query.orderBy([(b) => OrderingTerm(expression: b.audioSec)]);
      }

      final bookmarks = await query.get();
      return Success(bookmarks);
    } catch (e) {
      return Failure(AppError('Failed to get bookmarks: $e'));
    }
  }
}
