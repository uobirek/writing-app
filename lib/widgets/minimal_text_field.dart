import 'package:flutter/material.dart';

class MinimalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? textStyle;

  const MinimalTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyle ??
          const TextStyle(
            fontSize: 24, // Default font size for big, pretty text
            fontWeight: FontWeight.w600, // Semi-bold for emphasis
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle?.copyWith(color: Colors.grey) ??
            const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
        border: InputBorder.none, // No border
        isDense: true, // Minimal padding
        contentPadding: EdgeInsets.zero, // Remove internal padding
      ),
      cursorColor: Theme.of(context).colorScheme.secondary, // Pretty cursor
    );
  }
}
