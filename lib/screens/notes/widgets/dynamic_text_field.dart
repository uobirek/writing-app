import 'package:flutter/material.dart';

class DynamicTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isNumber;

  const DynamicTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
