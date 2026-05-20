import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:readease/data/db/migrations.dart';

part 'database.g.dart';

class Books extends Table {
  TextColumn get id => text()();
  TextColumn get path => text()();
  TextColumn get hash => text()();
  TextColumn get title => text()();
  TextColumn get author => text()();
  TextColumn get series => text().nullable()();
  TextColumn get genre => text().nullable()();
  TextColumn get tags => text()(); // JSON array
  TextColumn get type => textEnum<BookType>()();
  TextColumn get coverPath => text().nullable()();
  IntColumn get durationSec => integer().nullable()();
  IntColumn get pageCount => integer().nullable()();
  DateTimeColumn get addedAt => dateTime()();
  DateTimeColumn get lastOpenedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

enum BookType { pdf, epub, audio }

class ReadingPositions extends Table {
  TextColumn get bookId => text().references(Books, #id)();
  TextColumn get cfi => text().nullable()();
  IntColumn get page => integer().nullable()();
  IntColumn get audioSec => integer().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {bookId};
}

class Bookmarks extends Table {
  TextColumn get id => text()();
  TextColumn get bookId => text().references(Books, #id)();
  TextColumn get cfi => text().nullable()();
  IntColumn get page => integer().nullable()();
  IntColumn get audioSec => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get color => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Highlights extends Table {
  TextColumn get id => text()();
  TextColumn get bookId => text().references(Books, #id)();
  // For EPUB we store a CFI string; for PDF we may store page and a position fraction
  TextColumn get cfi => text().nullable()();
  IntColumn get page => integer().nullable()();
  // positionFraction is a value 0..10000 stored as integer (to avoid floating columns)
  IntColumn get positionFraction => integer().withDefault(Constant(0))();
  // Normalized bounding box (0..10000) relative to viewport used for inline overlays
  IntColumn get rectLeft => integer().withDefault(Constant(0))();
  IntColumn get rectTop => integer().withDefault(Constant(0))();
  IntColumn get rectWidth => integer().withDefault(Constant(0))();
  IntColumn get rectHeight => integer().withDefault(Constant(0))();
  TextColumn get excerpt => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get color => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Books, ReadingPositions, Bookmarks, Highlights])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Test-friendly constructor that accepts an existing [QueryExecutor].
  @visibleForTesting
  AppDatabase.withExecutor(QueryExecutor executor) : super(executor);

  /// Backwards compatible alias used in tests - accepts a [QueryExecutor].
  @visibleForTesting
  AppDatabase.withConnection(QueryExecutor executor) : super(executor);

  // bumped to 2 to include Highlights
  @override
  int get schemaVersion => 3; // v3: add highlight bounding box columns

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Forward all migrations in sequence for proper upgrade path
          if (from < 2) {
            // v1 -> v2: add highlights table
            await DbMigrations().v1tov2(m);
          }
          if (from < 3) {
            // v2 -> v3: add bbox columns
            await DbMigrations().v2tov3(m);
          }
        },
        beforeOpen: (details) async {
          // Ensure foreign keys are enabled
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
