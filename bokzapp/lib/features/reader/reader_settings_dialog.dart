import 'package:flutter/material.dart';
import 'package:readease/features/reader/reader_theme.dart';

class ReaderSettingsDialog extends StatelessWidget {
  final ReaderTheme currentTheme;
  final double currentFontSize;
  final ValueChanged<ReaderTheme> onThemeChanged;
  final ValueChanged<double> onFontSizeChanged;

  const ReaderSettingsDialog({
    super.key,
    required this.currentTheme,
    required this.currentFontSize,
    required this.onThemeChanged,
    required this.onFontSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reader Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Theme'),
          SegmentedButton<ReaderTheme>(
            segments: const [
              ButtonSegment(
                value: ReaderTheme.light,
                icon: Icon(Icons.light_mode),
                label: Text('Light'),
              ),
              ButtonSegment(
                value: ReaderTheme.dark,
                icon: Icon(Icons.dark_mode),
                label: Text('Dark'),
              ),
              ButtonSegment(
                value: ReaderTheme.sepia,
                icon: Icon(Icons.book),
                label: Text('Sepia'),
              ),
            ],
            selected: {currentTheme},
            onSelectionChanged: (theme) => onThemeChanged(theme.first),
          ),
          const SizedBox(height: 16),
          const Text('Font Size'),
          Slider(
            value: currentFontSize,
            min: 0.8,
            max: 1.4,
            divisions: 6,
            label: '${(currentFontSize * 100).round()}%',
            onChanged: onFontSizeChanged,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
