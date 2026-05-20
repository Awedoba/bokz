import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/repositories/providers.dart';
import 'package:shimmer/shimmer.dart';

final homeBooksStreamProvider = StreamProvider<List<Book>>((ref) {
  final repository = ref.watch(bookRepositoryProvider);
  return repository.watchRecentBooks();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider that streams the recent books (ordered by lastOpenedAt desc)
    final booksAsync = ref.watch(homeBooksStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadEase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      // Pull-to-refresh around the main scroll view
      body: RefreshIndicator(
        onRefresh: () async {
          // Force a requery; repository returns recent books and the stream will
          // update automatically when DB changes. We still call this to allow
          // a manual refresh gesture.
          final repo = ref.read(bookRepositoryProvider);
          await repo.getRecentBooks();
        },
        child: CustomScrollView(
          slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Continue Reading',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: booksAsync.when(
                data: (books) {
                  if (books.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No recent books'),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () => context.push('/import'),
                              child: const Text('Add Books'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return SizedBox(
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  switch (book.type) {
                                    case BookType.epub:
                                      context.push('/reader/epub/${book.id}');
                                    case BookType.pdf:
                                      context.push('/reader/pdf/${book.id}');
                                    case BookType.audio:
                                      context.push('/player/audio/${book.id}');
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Hero(
                                    tag: 'book-${book.id}',
                                    child: book.coverPath != null
                                        ? Image.file(
                                            File(book.coverPath!),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          )
                                        : Container(
                                            color: Colors.grey[200],
                                            child: const Center(
                                              child: Icon(Icons.book,
                                                  size: 48, color: Colors.grey),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              book.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              book.author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) => SizedBox(
                      width: 140,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(height: 12, color: Colors.white),
                            const SizedBox(height: 6),
                            Container(height: 10, width: 80, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                error: (e, st) => Center(child: Text('Error: $e')),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recommended for You',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // TODO: Implement recommendations section
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'New Releases',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // TODO: Implement new releases section
        ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books),
            label: 'My Books',
          ),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              break; // Already on home
            case 1:
              context.push('/explore');
              break;
            case 2:
              context.push('/collection');
              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/import'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
