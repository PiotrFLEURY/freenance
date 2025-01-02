import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/home/widgets/envelope_row.dart';
import 'package:freenance/view_model/providers.dart';

const double _kExpandedHeight = 0.65;

class HomeBottomSheet extends ConsumerWidget {
  const HomeBottomSheet({
    super.key,
    required this.currentBudget,
    required this.onAddEnvelope,
    required this.onEditEnvelope,
    required this.onDeleteEnvelope,
  });

  final Budget currentBudget;
  final void Function() onAddEnvelope;
  final void Function(Envelope) onEditEnvelope;
  final void Function(Envelope) onDeleteEnvelope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainColor = ref.watch(colorNotifierProvider).mainColor;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * _kExpandedHeight,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Restant',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${currentBudget.remainingAmount.toStringAsFixed(2)} €',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${currentBudget.remainingRatio.toStringAsFixed(0)} %',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LinearProgressIndicator(
                  minHeight: 32,
                  borderRadius: BorderRadius.circular(8),
                  value: currentBudget.remainingRatio / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: currentBudget.envelopes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: EnvelopeRow(
                  envelope: currentBudget.envelopes[index],
                  onTap: onEditEnvelope,
                  onDelete: onDeleteEnvelope,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
