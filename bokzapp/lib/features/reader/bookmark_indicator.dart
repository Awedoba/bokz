import 'package:flutter/material.dart';
import 'package:readease/data/db/database.dart';

/// A vertical bookmark indicator column placed in reader margins.
/// For PDF: it maps by page number using [totalPages] and Bookmark.page.
/// For EPUB: when page numbers are not available, it evenly distributes
/// markers by the number of bookmarks.
class BookmarkIndicator extends StatelessWidget {
  final double width;
  final double topPadding;
  final double bottomPadding;
  final int? totalPages;
  final List<Bookmark> bookmarks;
  final void Function(Bookmark) onTap;

  const BookmarkIndicator({
    super.key,
    this.width = 24,
    this.topPadding = 8,
    this.bottomPadding = 8,
    required this.bookmarks,
    this.totalPages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (bookmarks.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight - topPadding - bottomPadding;

      List<Widget> markers = [];

      for (var i = 0; i < bookmarks.length; i++) {
        final bm = bookmarks[i];
        double fraction = 0.0;
        if (bm.page != null && (totalPages ?? 0) > 0) {
          final pages = totalPages!.toDouble();
          fraction = ((bm.page! - 1).clamp(0, pages - 1)) / (pages - 1);
        } else {
          // fallback: distribute by index
          fraction =
              (bookmarks.length <= 1) ? 0.5 : (i / (bookmarks.length - 1));
        }

        final top = topPadding + (height * fraction) - 8; // center marker

        markers.add(Positioned(
          top: top.clamp(0.0, constraints.maxHeight - 16),
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => onTap(bm),
            child: Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _colorFromName(bm.color) ??
                      Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }

      return SizedBox(
        width: width,
        child: Stack(
          children: markers,
        ),
      );
    });
  }

  Color? _colorFromName(String? name) {
    switch (name) {
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
        return null;
    }
  }
}
