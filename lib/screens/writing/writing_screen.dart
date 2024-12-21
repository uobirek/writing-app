import 'package:flutter/material.dart';
import 'package:writing_app/widgets/sidebar_layout.dart';

class WritingScreen extends StatefulWidget {
  @override
  _WritingScreenState createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _clearFields() {
    setState(() {
      _titleController.clear();
      _contentController.clear();
    });
  }

  void _saveWriting() {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title and content cannot be empty.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Simulate saving (e.g., saving to a database or file system)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved: $title'),
        backgroundColor: Colors.green,
      ),
    );

    // Optional: Clear fields after saving
    _clearFields();
  }

  @override
  Widget build(BuildContext context) {
    return SidebarLayout(
      activeRoute: '/writing',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Writing Screen'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveWriting,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _clearFields,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Input Field
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Writing Area
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null, // Allow multi-line input
                  expands: true, // Expand to fill available space
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Start writing your ideas here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

              // Buttons Row (Save and Clear)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: _clearFields,
                    icon: const Icon(Icons.delete),
                    label: const Text('Clear'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _saveWriting,
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
