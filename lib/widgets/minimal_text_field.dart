import 'package:flutter/material.dart';

class MinimalTextField extends StatelessWidget {
  const MinimalTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.textStyle,
    this.focusNode,
  });
  final TextEditingController controller;
  final String hintText;
  final TextStyle? textStyle;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: textStyle ??
          const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle?.copyWith(color: Colors.grey) ??
            const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      cursorColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
