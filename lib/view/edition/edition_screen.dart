import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/view/common/solid_button.dart';
import 'package:freenance/view/localization/freenance_localization.dart';
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
  final String? label;
  final double? amount;

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
    labelController.text = widget.label ?? '';
    amountController.text = widget.amount?.toString() ?? '';
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
              key: Key('edition_screen_label'),
              controller: labelController,
              focusNode: labelFocusNode,
              decoration: InputDecoration(
                labelText: context.translate('edition_screen_label'),
                hintText: context.translate('edition_screen_label_hint'),
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
              key: Key('edition_screen_amount'),
              controller: amountController,
              focusNode: amountFocusNode,
              decoration: InputDecoration(
                labelText: context.translate('edition_screen_amount'),
                hintText: context.translate('edition_screen_amount_hint'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
              ),
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            Spacer(),
            SolidButton(
              text: context.translate('edition_screen_cancel_button'),
              action: () => Voyager.pop(context),
              color: Colors.grey,
            ),
            SolidButton(
              text: context.translate('edition_screen_validate_button'),
              color: mainColor,
              action: () {
                final newLabel = labelController.text;
                final newAmount = double.tryParse(
                      amountController.text.replaceAll(',', '.'),
                    ) ??
                    0;

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
