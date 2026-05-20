import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/repositories/providers.dart';
import 'package:readease/features/reader/book_reader.dart'
    show BookReaderController;
import 'package:readease/features/reader/reader_theme.dart' show ReaderTheme;

class PdfViewerWidget extends StatelessWidget {
  final PdfReaderController controller;

  const PdfViewerWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (controller._pdfController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return PdfView(
      controller: controller._pdfController!,
      onPageChanged: (page) {
        // Page change is handled by controller's listener
      },
      builders: PdfViewBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        errorBuilder: (context, error) => Center(
          child: Text('Error: $error'),
        ),
        documentLoaderBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class PdfReaderController extends BookReaderController {
  PdfController? _pdfController;
  bool _isLoading = true;
  int _currentPage = 1;
  int _totalPages = 0;
  String? _error;

  @override
  bool get isLoading => _isLoading;

  @override
  double get progress => _totalPages == 0 ? 0 : _currentPage / _totalPages;

  @override
  String get currentPosition => _currentPage.toString();

  @override
  int get totalPages => _totalPages;

  @override
  bool get hasError => _error != null;

  @override
  String? get errorMessage => _error;

  Future<void> loadFile(String filePath) async {
    await initialize(filePath);
  }

  @override
  Future<void> initialize(String filePath) async {
    try {
      _isLoading = true;
      notifyListeners();

      _pdfController = PdfController(
        document: PdfDocument.openFile(filePath),
      );

      // Wait for document to load and get total pages
      final document = await _pdfController!.document;
      _totalPages = await document.pagesCount;
      _currentPage = 1;
      _isLoading = false;
      _error = null;

      // Track page changes through value notifier
      _pdfController!.pageListenable.addListener(() {
        if (_pdfController?.pageListenable.value != null) {
          _currentPage = _pdfController!.pageListenable.value! + 1;
          notifyListeners();
        }
      });

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> goToPosition(String position) async {
    final page = int.tryParse(position);
    if (page != null) await goToPage(page);
  }

  @override
  Future<void> goToPage(int page) async {
    if (_pdfController == null) return;
    if (page < 1 || page > _totalPages) throw RangeError('Invalid page number');

    // pdfx uses 0-based page numbers internally
    _pdfController!.jumpToPage(page - 1);
  }

  @override
  Future<void> search(String query) async {
    // TODO: PDF text search implementation
  }

  @override
  Future<void> updateTheme(dynamic theme) async {
    notifyListeners();
  }

  @override
  Future<void> updateFontSize(double size) async {
    notifyListeners();
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }
}

final pdfReaderControllerProvider = StateNotifierProvider.family<
    PdfReaderNotifier, AsyncValue<PdfReaderController>, String>((ref, bookId) {
  return PdfReaderNotifier(bookId, ref);
});

class PdfReaderNotifier extends StateNotifier<AsyncValue<PdfReaderController>> {
  final String bookId;
  final Ref ref;

  PdfReaderNotifier(this.bookId, this.ref) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    state = const AsyncValue.loading();
    try {
      final book = await ref.read(bookProvider(bookId).future);
      if (book == null) {
        state =
            AsyncValue.error(Exception('Book not found'), StackTrace.current);
        return;
      }

      final controller = PdfReaderController();
      await controller.loadFile(book.path);
      state = AsyncValue.data(controller);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final bookProvider = FutureProvider.family<Book?, String>((ref, bookId) async {
  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.getBook(bookId);
  return result.fold(
    onSuccess: (book) => book,
    onFailure: (error) => throw error,
  );
});

class PdfReaderScreen extends ConsumerWidget {
  final String bookId;

  const PdfReaderScreen({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pdfReaderControllerProvider(bookId));
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
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              // TODO: Implement zoom controls
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
      body: controller.when(
        data: (pdfController) => PdfViewerWidget(controller: pdfController),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
