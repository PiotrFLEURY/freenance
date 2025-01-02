import 'package:flutter/material.dart';
import 'package:freenance/view/common/solid_button.dart';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onCancel,
    required this.onConfirm,
  });

  final String title;
  final String message;

  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  bool _understood = false;

  void _checkUnderstood(bool value) {
    setState(() {
      _understood = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.message),
          SolidButton(
            action: widget.onCancel,
            text: 'Annuler',
          ),
          CheckboxListTile(
            value: _understood,
            onChanged: (value) => _checkUnderstood(value ?? false),
            title: Text('Je comprends'),
          ),
          SolidButton(
            action: widget.onConfirm,
            text: 'Confirmer',
            color: Colors.red,
            enabled: _understood,
          ),
        ],
      ),
    );
  }
}
