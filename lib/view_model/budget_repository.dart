import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/logic/budget_repository.dart';
import 'package:freenance/view_model/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_repository.g.dart';

@riverpod
BudgetRepository budgetRepository(Ref ref) {
  final db = ref.watch(databaseProvider);
  return BudgetRepository(db);
}
