import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputType = TextInputType.text,
    this.isMandatory = false,
    this.inputFormatters = const [],
    this.maxLength = 25,
    this.onChanged,
    this.enabled = true,
  });
  final TextEditingController controller;
  final String labelText;
  final TextInputType textInputType;
  final bool isMandatory;
  final List<TextInputFormatter> inputFormatters;
  final int maxLength;
  final void Function(String)? onChanged;
  final bool enabled;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        counterText: "",
      ),
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      validator: (value) {
        if (value!.isEmpty && widget.isMandatory) {
          return 'Field cannot be empty';
        }
        return null;
      },
      enabled: widget.enabled,
    );
  }
}
