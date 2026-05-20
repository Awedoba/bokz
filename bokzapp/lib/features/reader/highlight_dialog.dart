import 'package:flutter/material.dart';

class HighlightDialog extends StatefulWidget {
  final String? initialNote;
  final String? initialExcerpt;
  final String? initialColor;
  final void Function(String note, String excerpt, String color) onSave;

  const HighlightDialog({
    super.key,
    this.initialNote,
    this.initialExcerpt,
    this.initialColor,
    required this.onSave,
  });

  @override
  State<HighlightDialog> createState() => _HighlightDialogState();
}

class _HighlightDialogState extends State<HighlightDialog> {
  late final TextEditingController _noteController;
  late final TextEditingController _excerptController;
  String _selectedColor = 'yellow';

  static const _colors = {
    'yellow': Colors.yellow,
    'green': Colors.green,
    'blue': Colors.blue,
    'pink': Colors.pink,
    'purple': Colors.purple,
  };

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
    _excerptController = TextEditingController(text: widget.initialExcerpt);
    _selectedColor = widget.initialColor ?? 'yellow';
  }

  @override
  void dispose() {
    _noteController.dispose();
    _excerptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Highlight'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _excerptController,
              decoration: const InputDecoration(
                labelText: 'Excerpt',
                hintText: 'Selected text (optional)',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note',
                hintText: 'Add a note (optional)',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            const Text('Color'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _colors.entries.map((e) {
                return InkWell(
                  onTap: () => setState(() => _selectedColor = e.key),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: e.value,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedColor == e.key
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            widget.onSave(
                _noteController.text, _excerptController.text, _selectedColor);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
