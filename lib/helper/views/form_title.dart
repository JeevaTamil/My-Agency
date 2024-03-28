import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({
    super.key,
    required this.isEdit,
    required this.title,
  });

  final bool isEdit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      isEdit ? 'Edit $title' : 'Add $title',
    );
  }
}
