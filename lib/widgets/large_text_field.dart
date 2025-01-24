import 'package:flutter/material.dart';
import 'package:writing_app/utils/input_decoration.dart';

class LargeTextField extends StatefulWidget {
  const LargeTextField({
    super.key,
    required this.controller,
    required this.label,
  });
  final TextEditingController controller;
  final String label;

  @override
  _LargeTextFieldState createState() => _LargeTextFieldState();
}

class _LargeTextFieldState extends State<LargeTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {});
        },
        onExit: (_) {
          setState(() {});
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: TextFormField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            controller: widget.controller,
            focusNode: _focusNode,
            decoration: formInputDecoration(
              context: context,
              label: widget.label,
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null, // Dynamically grow with content
            minLines: 1, // Start with a single line
          ),
        ),
      ),
    );
  }
}
