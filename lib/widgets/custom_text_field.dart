import 'package:flutter/material.dart';
import 'package:writing_app/screens/notes/widgets/input_decoration.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isNumber = false,
  });
  final TextEditingController controller;
  final String label;
  final bool isNumber;

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
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
        child: SizedBox(
          width: 400,
          child: TextFormField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            controller: widget.controller,
            focusNode: _focusNode,
            decoration:
                formInputDecoration(context: context, label: widget.label),
            keyboardType:
                widget.isNumber ? TextInputType.number : TextInputType.text,
          ),
        ),
      ),
    );
  }
}
