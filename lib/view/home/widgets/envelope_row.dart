import 'package:flutter/material.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/envelope/envelope_screen.dart';

class EnvelopeRow extends StatelessWidget {
  const EnvelopeRow({
    super.key,
    required this.envelope,
    required this.onDelete,
  });

  final Envelope envelope;
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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EnvelopeScreen(
                envelopeId: envelope.id,
              ),
            ),
          );
        },
        leading: Icon(Icons.shopping_cart_outlined),
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
