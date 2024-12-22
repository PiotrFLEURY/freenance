import 'package:flutter/material.dart';
import 'package:freenance/model/objects/operation.dart';

class OperationRow extends StatelessWidget {
  const OperationRow({
    super.key,
    required this.operation,
  });

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            operation.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            ' - ${operation.amount.toStringAsFixed(0)} €',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      subtitle: Text(
        operation.date.toString(),
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
