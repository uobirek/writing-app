import 'package:flutter/material.dart';

class DynamicListField extends StatelessWidget {
  const DynamicListField({
    super.key,
    required this.context,
    required this.label,
    required this.list,
  });

  final BuildContext context;
  final String label;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: list[index],
                    decoration: const InputDecoration(hintText: 'Enter item'),
                    onChanged: (value) {
                      list[index] = value; // Update list item
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete,
                      color: Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    list.removeAt(index); // Remove item
                    (context as Element).markNeedsBuild(); // Rebuild UI
                  },
                ),
              ],
            );
          },
        ),
        TextButton.icon(
          icon: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary),
          label: const Text('Add Item'),
          onPressed: () {
            list.add(''); // Add an empty item
            (context as Element).markNeedsBuild(); // Rebuild UI
          },
        ),
      ],
    );
  }
}
