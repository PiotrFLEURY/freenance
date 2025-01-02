import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/view/common/solid_button.dart';
import 'package:freenance/view/router/voyager.dart';
import 'package:freenance/view_model/providers.dart';

class EditionScreen extends ConsumerStatefulWidget {
  const EditionScreen({
    super.key,
    required this.title,
    required this.label,
    required this.amount,
  });

  final String title;
  final String label;
  final double amount;

  @override
  ConsumerState<EditionScreen> createState() => _BudgetEditionDialogState();
}

class _BudgetEditionDialogState extends ConsumerState<EditionScreen> {
  final labelController = TextEditingController();
  final amountController = TextEditingController();

  final labelFocusNode = FocusNode();
  final amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    labelController.text = widget.label;
    amountController.text = widget.amount.toString();
    labelFocusNode.addListener(
      () {
        if (labelFocusNode.hasFocus) {
          labelController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: labelController.text.length,
          );
        }
      },
    );
    amountFocusNode.addListener(
      () {
        if (amountFocusNode.hasFocus) {
          amountController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: amountController.text.length,
          );
        }
      },
    );
    labelFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = ref.watch(colorNotifierProvider).mainColor;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            SizedBox(height: 48),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Voyager.pop(context),
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            TextField(
              controller: labelController,
              focusNode: labelFocusNode,
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
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: amountController,
              focusNode: amountFocusNode,
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
            Spacer(),
            SolidButton(
              text: 'Annuler',
              action: () => Voyager.pop(context),
              color: Colors.grey,
            ),
            SolidButton(
              text: 'Valider',
              color: mainColor,
              action: () {
                final newLabel = labelController.text;
                final newAmount = double.parse(amountController.text);
                Voyager.pop(context, (newLabel, newAmount));
              },
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
