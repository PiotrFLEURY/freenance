import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/view_model/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'budget_list.g.dart';

@riverpod
Future<List<Budget>> budgetList(Ref ref) async {
  final repo = ref.watch(budgetRepositoryProvider);
  return repo.fetchBudgets();
}
