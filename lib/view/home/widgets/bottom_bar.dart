import 'package:flutter/material.dart';
import 'package:freenance/view/common/solid_button.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.onAddEnvelope});

  final void Function() onAddEnvelope;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 24.0,
          left: 16.0,
          right: 16.0,
        ),
        child: SolidButton(
          icon: Icons.add,
          text: 'Ajouter une enveloppe',
          action: onAddEnvelope,
        ),
      ),
    );
  }
}
