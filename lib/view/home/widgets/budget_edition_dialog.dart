import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/view/common/solid_button.dart';
import 'package:freenance/view_model/providers.dart';

class BudgetEditionDialog extends ConsumerStatefulWidget {
  const BudgetEditionDialog({super.key, required this.budget});

  final Budget budget;

  @override
  ConsumerState<BudgetEditionDialog> createState() =>
      _BudgetEditionDialogState();
}

class _BudgetEditionDialogState extends ConsumerState<BudgetEditionDialog> {
  final labelController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labelController.text = widget.budget.label;
    amountController.text = widget.budget.amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = ref.watch(colorNotifierProvider).mainColor;
    return AlertDialog(
      title: Text('Editer le budget'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: labelController,
            decoration: InputDecoration(
              labelText: 'Budget',
              hintText: 'Mon Budget',
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
            controller: amountController,
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
          ),
          SizedBox(height: 16),
          SolidButton(
            text: 'Valider',
            color: mainColor,
            action: () {
              final newBudget = Budget(
                id: widget.budget.id,
                label: labelController.text,
                amount: double.parse(amountController.text),
                envelopes: widget.budget.envelopes,
              );
              Navigator.of(context).pop(
                newBudget,
              );
            },
          ),
        ],
      ),
    );
  }
}
