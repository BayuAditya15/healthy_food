import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int qty;
  final Function(int) onChanged;

  const QuantitySelector({
    super.key,
    required this.qty,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: qty > 1 ? () => onChanged(qty - 1) : null,
          icon: const Icon(Icons.remove),
        ),
        Text(qty.toString()),
        IconButton(
          onPressed: () => onChanged(qty + 1),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
