import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isNumber;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isNumber = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Listen to focus changes
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = _focusNode.hasFocus;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: SizedBox(
          width: 500,
          child: TextFormField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            controller: widget.controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyLarge,
              labelText: widget.label,
              filled: true,
              focusColor: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withValues(alpha: 0.3),
              hoverColor: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withValues(alpha: 0.3),
              fillColor: Theme.of(context).colorScheme.surface,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
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
            ),
            keyboardType:
                widget.isNumber ? TextInputType.number : TextInputType.text,
          ),
        ),
      ),
    );
  }
}
