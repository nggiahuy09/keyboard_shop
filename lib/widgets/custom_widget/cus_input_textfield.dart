import 'package:flutter/material.dart';

class CusInputTextField extends StatelessWidget {
  const CusInputTextField({
    super.key,
    required this.editingController,
    required this.hintText,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.suffix,
  });

  final TextEditingController editingController;
  final String hintText;
  final bool obscureText;
  final TextInputType inputType;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: editingController,
        onChanged: (value) => editingController.text = value,
        maxLines: 1,
        obscureText: obscureText,
        keyboardType: inputType,
        onTapOutside: (e) => FocusScope.of(context).unfocus(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          suffixIcon: suffix,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          )
        ),
      ),
    );
  }
}
