import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view_model/providers.dart';

class EnvelopeRow extends ConsumerWidget {
  const EnvelopeRow({
    super.key,
    required this.envelope,
    required this.onDelete,
    required this.onTap,
  });

  final Envelope envelope;
  final void Function(Envelope) onTap;
  final void Function(Envelope) onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final envelopeColor = ref.watch(colorNotifierProvider).envelopeColor(
          envelope.id,
        );
    return GestureDetector(
      key: Key('${envelope.id}'),
      onLongPress: () {
        onDelete(envelope);
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          onTap: () => onTap(envelope),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.mail_outline,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                envelope.label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${envelope.amount} €',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: envelopeColor,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: LinearProgressIndicator(
              value: envelope.remainingRatio,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(envelopeColor),
              minHeight: 24,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
