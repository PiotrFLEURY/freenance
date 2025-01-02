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
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.arrow_downward_outlined),
        ),
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
                fontSize: 18,
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
      ),
    );
  }
}
