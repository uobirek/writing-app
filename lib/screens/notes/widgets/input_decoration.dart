import 'package:flutter/material.dart';

InputDecoration formInputDecoration({
  required BuildContext context,
  required String label,
}) {
  return InputDecoration(
    constraints:
        const BoxConstraints(minHeight: 40, minWidth: 100, maxWidth: 350),
    labelStyle: Theme.of(context).textTheme.bodyLarge,
    labelText: label,
    filled: true,
    focusColor: Theme.of(context).colorScheme.secondary.withAlpha(30),
    fillColor: Theme.of(context).colorScheme.surface,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primaryContainer,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    ),
  );
}
