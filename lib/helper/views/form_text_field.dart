import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputType = TextInputType.text,
    this.isMandatory = false,
  });
  final TextEditingController controller;
  final String labelText;
  final TextInputType textInputType;
  final bool isMandatory;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty && widget.isMandatory) {
          return 'Field cannot be empty';
        }
        return null;
      },
    );
  }
}
