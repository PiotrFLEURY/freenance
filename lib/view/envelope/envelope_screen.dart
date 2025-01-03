import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/model/objects/operation.dart';
import 'package:freenance/view/common/solid_button.dart';
import 'package:freenance/view/envelope/widgets/operation_row.dart';
import 'package:freenance/view/router/voyager.dart';
import 'package:freenance/view_model/providers.dart';

class EnvelopeScreen extends ConsumerStatefulWidget {
  const EnvelopeScreen({
    super.key,
    required this.envelopeId,
  });

  final int envelopeId;

  @override
  ConsumerState<EnvelopeScreen> createState() => _EnvelopeScreenState();
}

class _EnvelopeScreenState extends ConsumerState<EnvelopeScreen> {
  List<Operation> _filteredOperations = [];

  List<Operation> _operationList(Envelope envelope) {
    if (_filteredOperations.isEmpty) {
      return envelope.operations;
    }
    return _filteredOperations;
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(envelopeProvider(widget.envelopeId)).when(
          data: (envelope) {
            return _buildEnvelopeScreen(context, envelope);
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            return Scaffold(
              body: Center(
                child: Text(
                  'An error occurred: $error\n\n $stackTrace',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            );
          },
        );
  }

  Widget _buildEnvelopeScreen(BuildContext context, Envelope envelope) {
    final envelopeColor = ref.watch(colorNotifierProvider).envelopeColor(
          envelope.id,
        );
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          ref.invalidate(budgetListProvider);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Envelope ${envelope.label}'),
          actions: [
            IconButton(
              icon: Icon(Icons.color_lens_outlined),
              onPressed: () {
                _changeEnvelopeColor(context, envelope);
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => _editEnvelope(context, envelope),
                child: Text(
                  '${envelope.amount.toStringAsFixed(2)} €',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: envelopeColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Restant ${envelope.remainingAmount} €',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Recherche',
                  hintText: 'courses, loyer, ...',
                  suffixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _filteredOperations = envelope.operations;
                    });
                  } else {
                    setState(() {
                      _filteredOperations = envelope.operations
                          .where(
                            (operation) => operation.label
                                .toLowerCase()
                                .contains(value.toLowerCase()),
                          )
                          .toList();
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _operationList(envelope).length,
                itemBuilder: (context, index) {
                  final operation = _operationList(envelope)[index];
                  return Dismissible(
                    key: Key('${operation.id}'),
                    onDismissed: (_) => _deleteOperation(
                      context,
                      envelope,
                      operation,
                    ),
                    child: InkWell(
                      onTap: () => _editOperation(
                        context,
                        operation,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OperationRow(
                          operation: operation,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Separation line
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '- ${envelope.totalOperations} €',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SolidButton(
                icon: Icons.arrow_downward,
                text: 'Ajouter une opération',
                color: envelopeColor,
                action: () => _addOperation(context, envelope),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _editEnvelope(BuildContext context, Envelope envelope) async {
    final (String, double)? values = await Voyager.pushEdition(
      context,
      'Modifier l\'enveloppe',
      envelope.label,
      envelope.amount,
    );
    if (values == null) {
      return;
    }
    envelope.label = values.$1;
    envelope.amount = values.$2;

    ref.read(budgetRepositoryProvider).editEnvelope(envelope);
    ref.invalidate(envelopeProvider(widget.envelopeId));
  }

  Future<void> _editOperation(
    BuildContext context,
    Operation operation,
  ) async {
    final (String, double)? values = await Voyager.pushEdition(
      context,
      'Modifier l\'opération',
      operation.label,
      operation.amount,
    );
    if (values == null) {
      return;
    }
    operation.label = values.$1;
    operation.amount = values.$2;
    ref.read(budgetRepositoryProvider).editOperation(operation);
    ref.invalidate(envelopeProvider(widget.envelopeId));
  }

  Future<void> _addOperation(
    BuildContext context,
    Envelope envelope,
  ) async {
    (String, double)? values = await Voyager.pushEdition(
      context,
      'Ajouter une opération',
      'Nouvelle opération',
      0,
    );
    if (values == null) {
      return;
    }
    await ref.read(budgetRepositoryProvider).addOperation(
          envelope,
          values.$1,
          values.$2,
        );
    ref.invalidate(envelopeProvider(widget.envelopeId));
    _filteredOperations = [];
  }

  Future<void> _deleteOperation(
    BuildContext context,
    Envelope envelope,
    Operation operation,
  ) async {
    // First remove the operation from the envelope in order
    // to avoid dissmisible error
    envelope.operations.remove(operation);
    ref.read(budgetRepositoryProvider).deleteOperation(operation);
    ref.invalidate(envelopeProvider(widget.envelopeId));
    _filteredOperations = [];
  }

  Future<void> _changeEnvelopeColor(
    BuildContext context,
    Envelope envelope,
  ) async {
    // Fetch current color theme
    final colorTheme = ref.watch(colorNotifierProvider);

    // Fetch the current color of the envelope
    final envelopeColor = colorTheme.envelopeRgb(envelope.id);

    // Open the color picker
    final (double, double, double)? rgb = await Voyager.showColorPicker(
      context,
      envelopeColor.$1,
      envelopeColor.$2,
      envelopeColor.$3,
    );
    if (rgb == null) {
      ref.read(colorNotifierProvider.notifier).resetEnvelopeColor(
            envelope.id,
          );
    } else {
      // Update the color of the envelope
      ref.read(colorNotifierProvider.notifier).changeEnvelopeColor(
            envelope.id,
            rgb.$1,
            rgb.$2,
            rgb.$3,
          );
    }
  }
}
