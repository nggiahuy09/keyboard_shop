import 'dart:ui';

import 'package:flutter/material.dart';

class CusErrorText extends StatelessWidget {
  const CusErrorText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.red,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
