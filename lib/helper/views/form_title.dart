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
    return Row(
      children: [
        Text(
          isEdit ? 'Edit $title' : 'Add $title',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close_rounded)),
      ],
    );
  }
}
