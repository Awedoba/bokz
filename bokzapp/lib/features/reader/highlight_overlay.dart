import 'package:flutter/material.dart';
import 'package:readease/data/db/database.dart';

/// Widget that renders an overlay on top of reader content to show
/// highlighted text regions. Supports both EPUB CFI and PDF page/position
/// based highlights.
class HighlightOverlay extends StatelessWidget {
  final List<Highlight> highlights;
  final Map<String, Rect> highlightBounds;
  final ScrollController? scrollController;
  final double viewportHeight;
  final double viewportWidth;
  final bool isPdf;
  final void Function(Highlight)? onEdit;
  final void Function(Highlight)? onDelete;

  const HighlightOverlay({
    super.key,
    required this.highlights,
    required this.highlightBounds,
    this.scrollController,
    required this.viewportHeight,
    required this.viewportWidth,
    this.isPdf = false,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (final highlight in highlights)
          if (highlightBounds.containsKey(highlight.id))
            Positioned(
              left: highlightBounds[highlight.id]!.left,
              top: highlightBounds[highlight.id]!.top,
              width: highlightBounds[highlight.id]!.width,
              height: highlightBounds[highlight.id]!.height,
              child: Container(
                decoration: BoxDecoration(
                  color: _colorFromName(highlight.color)?.withOpacity(0.3) ??
                      Colors.yellow.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Highlight'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (highlight.excerpt?.isNotEmpty == true) ...[
                                const Text('Excerpt:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(highlight.excerpt!),
                                const SizedBox(height: 8),
                              ],
                              if (highlight.note?.isNotEmpty == true) ...[
                                const Text('Note:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(highlight.note!),
                                const SizedBox(height: 8),
                              ],
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (onEdit != null) onEdit!(highlight);
                                    },
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Edit'),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (onDelete != null)
                                        onDelete!(highlight);
                                    },
                                    icon: const Icon(Icons.delete),
                                    label: const Text('Delete'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
      ],
    );
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
