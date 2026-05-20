import 'package:flutter/material.dart';
import 'package:readease/data/db/database.dart';

/// A simple vertical highlight indicator that shows highlights along the
/// right margin. For PDF we map by page number; for EPUB we distribute.
class HighlightIndicator extends StatelessWidget {
  final double width;
  final double topPadding;
  final double bottomPadding;
  final int? totalPages;
  final List<Highlight> highlights;
  final void Function(Highlight) onTap;

  const HighlightIndicator({
    super.key,
    this.width = 20,
    this.topPadding = 8,
    this.bottomPadding = 8,
    required this.highlights,
    this.totalPages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (highlights.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight - topPadding - bottomPadding;
      List<Widget> markers = [];

      for (var i = 0; i < highlights.length; i++) {
        final h = highlights[i];
        double fraction = 0.0;
        if (h.page != null && (totalPages ?? 0) > 0) {
          final pages = totalPages!.toDouble();
          fraction = ((h.page! - 1).clamp(0, pages - 1)) / (pages - 1);
        } else if (h.positionFraction != null) {
          fraction = (h.positionFraction! / 10000).clamp(0.0, 1.0);
        } else {
          fraction =
              (highlights.length <= 1) ? 0.5 : (i / (highlights.length - 1));
        }

        final top = topPadding + (height * fraction) - 6;

        markers.add(Positioned(
          top: top.clamp(0.0, constraints.maxHeight - 12),
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => onTap(h),
            child: Center(
              child: Container(
                width: 14,
                height: 12,
                decoration: BoxDecoration(
                  color: _colorFromName(h.color) ??
                      Colors.yellow.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(3),
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
        child: Stack(children: markers),
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
