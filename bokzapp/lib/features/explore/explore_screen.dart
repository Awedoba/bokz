import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/repositories/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Book>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.searchBooks(query);
  return result.fold(
    onSuccess: (books) => books,
    onFailure: (error) => throw error,
  );
});

class ExploreScreen extends HookConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              hintText: 'Search books...',
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
              leading: const Icon(Icons.search),
            ),
          ),
          Expanded(
            child: searchResults.when(
              data: (books) => books.isEmpty
                  ? const Center(
                      child: Text('No books found'),
                    )
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return ListTile(
                          title: Text(book.title),
                          subtitle: Text(book.author),
                          leading: book.coverPath != null
                              ? SizedBox(
                                  width: 40,
                                  child: Image.file(
                                    File(book.coverPath!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.book),
                          trailing: Text(book.type.name.toUpperCase()),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
