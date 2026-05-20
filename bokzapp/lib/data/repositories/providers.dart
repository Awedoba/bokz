import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/db/providers.dart';
import 'package:readease/data/repositories/book_repository.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftBookRepository(db);
});
