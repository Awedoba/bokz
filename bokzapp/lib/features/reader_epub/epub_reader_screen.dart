import 'dart:io';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/repositories/providers.dart';

final epubReaderControllerProvider =
    Provider.autoDispose.family<EpubController?, String>((ref, bookId) {
  final bookAsync = ref.watch(bookProvider(bookId));
  return bookAsync.when(
    data: (book) {
      if (book == null) return null;
      return EpubController(
        document: EpubDocument.openFile(File(book.path)),
      );
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

final bookProvider = FutureProvider.family<Book?, String>((ref, bookId) async {
  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.getBook(bookId);
  return result.fold(
    onSuccess: (book) => book,
    onFailure: (error) => throw error,
  );
});

class EpubReaderScreen extends HookConsumerWidget {
  final String bookId;

  const EpubReaderScreen({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerAsync = ref.watch(epubReaderControllerProvider(bookId));
    final book = ref.watch(bookProvider(bookId));

    return Scaffold(
      appBar: AppBar(
        title: book.when(
          data: (book) => Text(book?.title ?? 'Loading...'),
          loading: () => const Text('Loading...'),
          error: (error, _) => Text('Error: $error'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_size),
            onPressed: () {
              // TODO: Implement font size adjustment
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // TODO: Implement bookmarks
            },
          ),
        ],
      ),
      body: switch (controllerAsync) {
        null => const Center(child: CircularProgressIndicator()),
        final controller => EpubView(
            builders: EpubViewBuilders<DefaultBuilderOptions>(
              options: const DefaultBuilderOptions(),
              chapterDividerBuilder: (_) => const Divider(),
            ),
            controller: controller,
          ),
      },
    );
  }
}
