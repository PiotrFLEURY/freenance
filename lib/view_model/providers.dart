import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/logic/freenance_db.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/logic/budget_repository.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
FreenanceDb database(Ref ref) {
  return FreenanceDb()..init();
}

@riverpod
BudgetRepository budgetRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return BudgetRepository(db);
}

@riverpod
Future<List<Budget>> budgetList(Ref ref) async {
  final repo = ref.watch(budgetRepositoryProvider);
  return repo.fetchBudgets();
}

@riverpod
Future<Envelope> envelope(Ref ref, int envelopeId) async {
  final budgetRepository = ref.watch(budgetRepositoryProvider);
  final envelope = await budgetRepository.fetchEnvelope(envelopeId);
  return envelope;
}
