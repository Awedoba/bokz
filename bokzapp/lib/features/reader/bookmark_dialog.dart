import 'package:flutter/material.dart';

class BookmarkDialog extends StatefulWidget {
  final String? initialNote;
  final String? initialColor;
  final void Function(String note, String color) onSave;

  const BookmarkDialog({
    super.key,
    this.initialNote,
    this.initialColor,
    required this.onSave,
  });

  @override
  State<BookmarkDialog> createState() => _BookmarkDialogState();
}

class _BookmarkDialogState extends State<BookmarkDialog> {
  late final TextEditingController _noteController;
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
    _selectedColor = widget.initialColor ?? 'yellow';
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Bookmark'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              labelText: 'Note',
              hintText: 'Add a note (optional)',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
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
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            widget.onSave(_noteController.text, _selectedColor);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
