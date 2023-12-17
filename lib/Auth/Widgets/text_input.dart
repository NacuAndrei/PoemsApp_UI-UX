import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  const TextInput(
      {Key? key,
      required this.controller,
      required this.label,
      required this.validator})
      : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autofocus: false,
      decoration: InputDecoration(
          labelText: widget.label, border: const OutlineInputBorder()),
    );
  }
}
