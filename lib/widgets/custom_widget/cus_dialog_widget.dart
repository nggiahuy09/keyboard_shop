import 'package:flutter/material.dart';

class CusConfirmationDialog extends StatelessWidget {
  const CusConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.acceptOption,
    required this.denyOption,
  });

  final String title;
  final String content;
  final TextButton acceptOption;
  final TextButton denyOption;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        denyOption,
        acceptOption,
      ],
    );
  }
}
