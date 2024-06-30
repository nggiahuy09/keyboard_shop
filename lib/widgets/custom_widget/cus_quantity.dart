import 'package:flutter/material.dart';

class CusQuantityWidget extends StatefulWidget {
  const CusQuantityWidget({
    super.key,
    required this.quantity,
    required this.decrement,
    required this.increment,
  });

  final int quantity;
  final Function() increment;
  final Function() decrement;

  @override
  State<CusQuantityWidget> createState() => _CusQuantityWidgetState();
}

class _CusQuantityWidgetState extends State<CusQuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: widget.decrement,
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: 4),
        Text(
          widget.quantity < 10 ? '0${widget.quantity}' : '${widget.quantity}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: widget.increment,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
