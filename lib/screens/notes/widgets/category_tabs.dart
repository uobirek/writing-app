import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryTabs extends StatelessWidget {
  final String currentCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryTabs({
    super.key,
    required this.currentCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['Show All', 'Worldbuilding', 'Characters', 'Outline'];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Categories aligned to the left
          Row(
            children: categories.map((category) {
              final isActive = currentCategory == category;
              return InkWell(
                onTap: () => onCategorySelected(category),
                child: Container(
                  height: 50,
                  width: 150,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.primaryContainer,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              );
            }).toList(),
          ),
          InkWell(
            onTap: () => {context.go('/add_note')},
            child: Container(
              height: 50,
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Text(
                'Add Note',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
