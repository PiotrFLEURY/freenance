import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/view_model/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'envelope_created.g.dart';

@riverpod
class EnvelopeCreated extends _$EnvelopeCreated {
  @override
  Envelope? build() {
    return null;
  }

  Future<void> envelopeCreated(int budgetId) async {
    final budgetList = await ref.read(budgetListProvider.future);
    final budget = budgetList.firstWhere((b) => b.id == budgetId);
    final maxEnvelopeId =
        budget.envelopes.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    final envelope = budget.envelopes.firstWhere((e) => e.id == maxEnvelopeId);
    state = envelope;
  }
}
