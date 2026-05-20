import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/repositories/book_repository.dart';
import 'package:readease/data/repositories/providers.dart';
import 'package:readease/core/result.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

final importBooksProvider =
    StateNotifierProvider<ImportBooksNotifier, AsyncValue<void>>((ref) {
  return ImportBooksNotifier(ref.watch(bookRepositoryProvider));
});

class ImportBooksNotifier extends StateNotifier<AsyncValue<void>> {
  final BookRepository _bookRepository;
  final _uuid = const Uuid();

  ImportBooksNotifier(this._bookRepository)
      : super(const AsyncValue.data(null));

  Future<void> importBook({
    required String sourcePath,
    required String title,
    required String author,
    String? series,
    String? genre,
    List<String> tags = const [],
  }) async {
    state = const AsyncValue.loading();

    try {
      // 1. Determine book type from extension
      final extension = p.extension(sourcePath).toLowerCase();
      final type = switch (extension) {
        '.pdf' => BookType.pdf,
        '.epub' => BookType.epub,
        '.mp3' || '.m4a' || '.aac' => BookType.audio,
        _ => throw Exception('Unsupported file type: $extension'),
      };

      // 2. Copy file to app directory with unique name
      final appDir = await getApplicationDocumentsDirectory();
      final booksDir = Directory(p.join(appDir.path, 'books'));
      await booksDir.create(recursive: true);

      final id = _uuid.v4();
      final fileName = '$id$extension';
      final destPath = p.join(booksDir.path, fileName);

      await File(sourcePath).copy(destPath);

      // 3. Create book record
      final now = DateTime.now();
      final book = Book(
        id: id,
        path: destPath,
        hash: '', // TODO: Compute file hash
        title: title,
        author: author,
        series: series,
        genre: genre,
        tags: '', // TODO: JSON encode tags
        type: type,
        coverPath: null,
        durationSec: null,
        pageCount: null,
        addedAt: now,
        lastOpenedAt: now,
      );

      // Save and notify listeners; repository inserts into Drift which will
      // cause any StreamProvider watching the books table to emit a new value.
      final result = await _bookRepository.saveBook(book);
      if (result is Failure) {
        throw Exception(result.error.toString());
      }

      state = const AsyncValue.data(null);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}

class ImportBooksScreen extends HookConsumerWidget {
  const ImportBooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final importState = ref.watch(importBooksProvider);
    final titleController = TextEditingController();
    final authorController = TextEditingController();
    final seriesController = TextEditingController();
    final genreController = TextEditingController();
    String? selectedFilePath;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // File picker
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'epub', 'mp3', 'm4a', 'aac'],
                );
                if (result != null) {
                  selectedFilePath = result.files.single.path;
                  // Try to guess title from filename
                  final filename =
                      p.basenameWithoutExtension(selectedFilePath!);
                  titleController.text = filename;
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Select Book File'),
            ),
            const SizedBox(height: 16),

            // Book details form
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(
                labelText: 'Author *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: seriesController,
              decoration: const InputDecoration(
                labelText: 'Series (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: genreController,
              decoration: const InputDecoration(
                labelText: 'Genre (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Import button
            ElevatedButton(
              onPressed: importState.isLoading
                  ? null
                  : () async {
                      if (selectedFilePath == null ||
                          titleController.text.isEmpty ||
                          authorController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please select a file and fill required fields'),
                          ),
                        );
                        return;
                      }

                      await ref.read(importBooksProvider.notifier).importBook(
                        sourcePath: selectedFilePath!,
                        title: titleController.text,
                        author: authorController.text,
                        series: seriesController.text.isEmpty
                            ? null
                            : seriesController.text,
                        genre: genreController.text.isEmpty
                            ? null
                            : genreController.text,
                        tags: [], // TODO: Add tags input
                      );

                      if (!context.mounted) return;

                      if (importState.hasError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${importState.error}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Book imported successfully'),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
              child: importState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Import Book'),
            ),
          ],
        ),
      ),
    );
  }
}
