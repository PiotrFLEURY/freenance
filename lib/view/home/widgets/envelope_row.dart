import 'package:flutter/material.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/theme/colors.dart';

class EnvelopeRow extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
              color: mainColor,
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
