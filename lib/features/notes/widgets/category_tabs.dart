import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.currentCategory,
    required this.onCategorySelected,
    required this.categories,
  });

  final String currentCategory;
  final ValueChanged<String> onCategorySelected;
  final Map<String, String> categories; // Original-to-localized map

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: categories.keys.map((category) {
          final isActive = currentCategory == category;
          return InkWell(
            onTap: () => onCategorySelected(category), // Use the original key
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
                categories[category]!, // Use localized text here
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
