import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view/home/widgets/envelope_row.dart';
import 'package:freenance/view_model/providers.dart';

const double _kHeight = 0.15;
const double _kExpandedHeight = 0.6;

class HomeBottomSheetController {
  void Function() open = () {};
  void Function() close = () {};
}

class HomeBottomSheet extends ConsumerStatefulWidget {
  const HomeBottomSheet({
    super.key,
    required this.currentBudget,
    required this.onAddEnvelope,
    required this.onEditEnvelope,
    required this.onDeleteEnvelope,
    required this.onSizeChanged,
    required this.controller,
  });

  final Budget currentBudget;
  final void Function() onAddEnvelope;
  final void Function(Envelope) onEditEnvelope;
  final void Function(Envelope) onDeleteEnvelope;
  final void Function(bool)? onSizeChanged;
  final HomeBottomSheetController controller;

  @override
  ConsumerState<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends ConsumerState<HomeBottomSheet> {
  bool _isExpanded = false;
  late double _height;

  @override
  void initState() {
    super.initState();
    _height = _kHeight;
    widget.controller.open = _openBottomSheet;
    widget.controller.close = _closeBottomSheet;
  }

  void _openBottomSheet() {
    setState(() {
      _isExpanded = true;
      _height = _kExpandedHeight;
    });
    widget.onSizeChanged?.call(_isExpanded);
  }

  void _closeBottomSheet() {
    setState(() {
      _isExpanded = false;
      _height = _kHeight;
    });
    widget.onSizeChanged?.call(_isExpanded);
  }

  void _toggleBottomSheet() {
    setState(() {
      _isExpanded = !_isExpanded;
      _height = _isExpanded ? _kExpandedHeight : _kHeight;
    });
    widget.onSizeChanged?.call(_isExpanded);
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
        _height = _kExpandedHeight;
      });
    } else {
      setState(() {
        _height = _kHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = ref.watch(colorNotifierProvider).mainColor;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * _height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _isExpanded
            ? BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
            : BorderRadius.zero,
      ),
      child: CustomScrollView(
        slivers: [
          // Bottom sheet drag handle
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: _toggleBottomSheet,
              onVerticalDragUpdate: (details) =>
                  _changeHeight(context, details.delta.dy),
              onVerticalDragEnd: (_) => _onDragEnd(),
              child: Center(
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
            ),
          ),
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
                    '${widget.currentBudget.remainingAmount.toStringAsFixed(2)} €',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 16,
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
          ),

          if (_isExpanded)
            SliverList.builder(
              itemCount: widget.currentBudget.envelopes.length,
              itemBuilder: (context, index) {
                return EnvelopeRow(
                  envelope: widget.currentBudget.envelopes[index],
                  onTap: widget.onEditEnvelope,
                  onDelete: widget.onDeleteEnvelope,
                );
              },
            ),
        ],
      ),
    );
  }
}
