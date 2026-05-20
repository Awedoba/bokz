import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readease/data/db/database.dart';
import 'package:readease/data/repositories/bookmark_repository.dart';
import 'package:readease/features/reader/bookmark_dialog.dart';

class BookmarkListView extends ConsumerWidget {
  final String bookId;
  final void Function(String position)? onBookmarkSelected;

  const BookmarkListView({
    super.key,
    required this.bookId,
    this.onBookmarkSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Bookmark>>(
      stream: ref.watch(bookmarkRepositoryProvider).watchBookmarks(bookId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final bookmarks = snapshot.data!;
        if (bookmarks.isEmpty) {
          return const Center(
            child: Text('No bookmarks yet'),
          );
        }

        return ListView.builder(
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final bookmark = bookmarks[index];
            return ListTile(
              leading: Icon(
                Icons.bookmark,
                color: _getColorFromName(bookmark.color),
              ),
              title: Text(bookmark.note ?? 'Bookmark ${index + 1}'),
              subtitle: Text(_getPositionText(bookmark)),
              onTap: () {
                if (onBookmarkSelected != null) {
                  final position = bookmark.cfi ?? bookmark.page?.toString();
                  if (position != null) {
                    onBookmarkSelected!(position);
                  }
                }
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref
                      .read(bookmarkRepositoryProvider)
                      .deleteBookmark(bookmark.id);
                },
              ),
            );
          },
        );
      },
    );
  }

  String _getPositionText(Bookmark bookmark) {
    if (bookmark.cfi != null) {
      return 'Location ${bookmark.cfi}';
    } else if (bookmark.page != null) {
      return 'Page ${bookmark.page}';
    } else if (bookmark.audioSec != null) {
      final minutes = bookmark.audioSec! ~/ 60;
      final seconds = bookmark.audioSec! % 60;
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
    return '';
  }

  Color? _getColorFromName(String? colorName) {
    switch (colorName) {
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.yellow;
    }
  }
}
