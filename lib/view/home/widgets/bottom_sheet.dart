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
  initState() {
    super.initState();
    _height = 0.2;
  }

  _toggleBottomSheet() {
    setState(() {
      _isExpanded = !_isExpanded;
      _height = _isExpanded ? 0.7 : 0.2;
    });
  }

  _changeHeight(BuildContext context, double delta) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double newHeight = screenHeight * _height + -1 * delta;
    if (newHeight > screenHeight * 0.2 && newHeight < screenHeight * 0.7) {
      setState(() {
        _height = newHeight / screenHeight;
      });
    }
  }

  _onDragEnd() {
    if (_height > 0.5) {
      setState(() {
        _height = 0.7;
        _isExpanded = true;
      });
    } else {
      setState(() {
        _height = 0.2;
        _isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * _height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
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
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
            ),
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
                    widget.currentBudget.remainingRatio.toStringAsFixed(0) +
                        ' %',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              subtitle: LinearProgressIndicator(
                value: widget.currentBudget.remainingRatio / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(mainColor),
              ),
            ),
          ),
          Text(
            widget.currentBudget.remainingAmount.toStringAsFixed(2) + ' €',
            style: TextStyle(
              color: mainColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
