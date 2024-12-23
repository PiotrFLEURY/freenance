import 'package:flutter/material.dart';
import 'package:freenance/view/common/solid_button.dart';

class EditionDialog extends StatefulWidget {
  const EditionDialog({
    super.key,
    required this.title,
    required this.label,
    required this.amount,
  });

  final String title;
  final String label;
  final double amount;

  @override
  State<EditionDialog> createState() => _EditionDialogState();
}

class _EditionDialogState extends State<EditionDialog> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _labelController.text = widget.label;
    _amountController.text = widget.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _labelController,
            decoration: InputDecoration(
              labelText: 'Label',
              hintText: 'Achat de chaussures, ...',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
              labelText: 'Montant',
              hintText: '0',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade300,
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          SolidButton(
            text: 'Valider',
            action: () {
              Navigator.of(context).pop(
                (_labelController.text, double.parse(_amountController.text)),
              );
            },
          ),
        ],
      ),
    );
  }
}
