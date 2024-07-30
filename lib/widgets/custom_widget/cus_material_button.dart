import 'package:flutter/material.dart';

class CusMaterialButton extends StatelessWidget {
  const CusMaterialButton({
    super.key,
    required this.content,
    this.subContent = '',
    this.minWidth = 0,
    this.height = 40,
    this.fontSizeContent = 22,
    required this.onTap,
  });

  final String content;
  final double fontSizeContent;
  final String subContent;
  final Function() onTap;
  final double minWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth == 0 ? double.infinity : minWidth,
      height: height,
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
    this.height = 40,
    this.fontSizeContent = 22,
    this.fontSizeSubContent = 16,
    required this.onTap,
  });

  final String content;
  final String subContent;
  final Function() onTap;
  final double fontSizeContent;
  final double fontSizeSubContent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: height,
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
              fontSize: fontSizeContent,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          if (subContent.isNotEmpty)
            Text(
              subContent,
              style: TextStyle(
                fontSize: fontSizeSubContent,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
        ],
      ),
    );
  }
}

class CusMaterialIconButton extends StatelessWidget {
  const CusMaterialIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.color,
    this.width,
    this.height,
  });

  final IconData icon;
  final Function() onTap;
  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      height: height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: color,
      onPressed: onTap,
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
