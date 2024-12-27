import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/home/widgets/envelope_row.dart';
import 'package:freenance/view/theme/colors.dart';
import 'package:freenance/view/common/solid_button.dart';
// ignore: unused_import
import 'package:freenance/view_model/providers.dart';

class HomeBottomSheet extends ConsumerStatefulWidget {
  const HomeBottomSheet({
    super.key,
    required this.currentBudget,
    required this.onAddEnvelope,
    required this.onDeleteEnvelope,
  });

  final Budget currentBudget;
  final void Function() onAddEnvelope;
  final void Function(Envelope) onDeleteEnvelope;

  @override
  ConsumerState<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends ConsumerState<HomeBottomSheet> {
  bool _isExpanded = false;
  late double _height;

  @override
  void initState() {
    super.initState();
    _height = 0.2;
  }

  void _toggleBottomSheet() {
    setState(() {
      _isExpanded = !_isExpanded;
      _height = _isExpanded ? 0.7 : 0.2;
    });
  }

  void _changeHeight(BuildContext context, double delta) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double newHeight = screenHeight * _height + -1 * delta;
    if (newHeight > screenHeight * 0.2 && newHeight < screenHeight * 0.7) {
      setState(() {
        _height = newHeight / screenHeight;
      });
    }
  }

  void _onDragEnd() {
    if (_height > 0.5) {
      setState(() {
        _height = 0.7;
      });
    } else {
      setState(() {
        _height = 0.2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      onEnd: () => setState(() {
        if (_height == 0.7) {
          _isExpanded = true;
        } else {
          _isExpanded = false;
        }
      }),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * _height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Bottom sheet drag handle
          GestureDetector(
            onTap: _toggleBottomSheet,
            onVerticalDragUpdate: (details) =>
                _changeHeight(context, details.delta.dy),
            onVerticalDragEnd: (_) => _onDragEnd(),
            child: Container(
              width: 80,
              height: 8,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          ListTile(
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
                  '${widget.currentBudget.remainingAmount.toStringAsFixed(2)} €',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.currentBudget.remainingRatio.toStringAsFixed(0) + ' %',
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
                value: widget.currentBudget.remainingRatio / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(mainColor),
              ),
            ),
          ),

          if (_isExpanded)
            Expanded(
              child: ListView.builder(
                itemCount: widget.currentBudget.envelopes.length,
                itemBuilder: (context, index) {
                  return EnvelopeRow(
                    envelope: widget.currentBudget.envelopes[index],
                    onDelete: widget.onDeleteEnvelope,
                  );
                },
              ),
            ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SolidButton(
                text: 'Ajouter',
                action: widget.onAddEnvelope,
              ),
            ),
        ],
      ),
    );
  }
}
