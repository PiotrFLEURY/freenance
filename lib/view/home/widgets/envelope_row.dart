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
    return Dismissible(
      key: Key('${envelope.id}'),
      onDismissed: (_) {
        onDelete(envelope);
      },
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: ListTile(
        onTap: () => onTap(envelope),
        leading: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: envelope.remainingRatio,
              color: envelopeColor,
              strokeWidth: 4,
              strokeCap: StrokeCap.round,
            ),
            Icon(Icons.mail_outline),
          ],
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
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${envelope.totalOperations} €'),
            Text('${envelope.operationCount} opérations'),
          ],
        ),
      ),
    );
  }
}
