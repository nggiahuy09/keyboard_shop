import 'package:flutter/material.dart';

class CusMaterialButton extends StatelessWidget {
  const CusMaterialButton({
    super.key,
    required this.content,
    this.subContent = '',
    this.minWidth = 0,
    this.fontSizeContent = 22,
    required this.onTap,
  });

  final String content;
  final double fontSizeContent;
  final String subContent;
  final Function() onTap;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth == 0 ? double.infinity : minWidth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      color: Colors.indigo[900],
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            content,
            style: TextStyle(
              fontSize: fontSizeContent,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          if (subContent.isNotEmpty)
            Text(
              subContent,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
        ],
      ),
    );
  }
}

class CusMaterialButtonAccent extends StatelessWidget {
  const CusMaterialButtonAccent({
    super.key,
    required this.content,
    this.subContent = '',
    required this.onTap,
  });

  final String content;
  final String subContent;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: subContent.isNotEmpty
          ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0)
          : const EdgeInsets.symmetric(vertical: 12, horizontal: 8.0),
      color: Colors.indigo[300]?.withOpacity(0.5),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            content,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          if (subContent.isNotEmpty)
            Text(
              subContent,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
        ],
      ),
    );
  }
}
