import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/widgets/input_decoration.dart';

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
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
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
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: SizedBox(
                          width: 400,
                          child: TextFormField(
                            initialValue: list[index],
                            decoration: formInputDecoration(
                              context: context,
                              label: '',
                            ),
                            onChanged: (value) {
                              list[index] = value;
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          list.removeAt(index);
                          (context as Element).markNeedsBuild();
                        },
                      ),
                    ],
                  );
                },
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                label: const Text('Add Item'),
                onPressed: () {
                  list.add(''); // Add an empty item
                  (context as Element).markNeedsBuild(); // Rebuild UI
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
