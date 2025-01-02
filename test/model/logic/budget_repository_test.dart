import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:freenance/model/logic/budget_repository.dart';
import 'package:freenance/model/logic/freenance_db.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/model/objects/operation.dart';

import 'budget_repository_test.mocks.dart';

@GenerateMocks([FreenanceDb])
void main() {
  group('BudgetRepository', () {
    late BudgetRepository budgetRepository;
    late MockFreenanceDb mockDb;

    setUp(() {
      mockDb = MockFreenanceDb();
      budgetRepository = BudgetRepository(mockDb);
    });

    test('fetchBudgets returns list of budgets', () async {
      final budgets = [
        Budget(id: 1, label: 'Test', amount: 100, envelopes: []),
      ];
      when(mockDb.findAllBudgets()).thenAnswer((_) async => budgets);

      final result = await budgetRepository.fetchBudgets();

      expect(result, budgets);
      verify(mockDb.findAllBudgets()).called(1);
    });

    test('saveBudget inserts new budget if id is 0', () async {
      final budget = Budget(id: 0, label: 'New', amount: 100, envelopes: []);

      await budgetRepository.saveBudget(budget);

      verify(mockDb.insertBudget(budget)).called(1);
    });

    test('saveBudget updates existing budget if id is not 0', () async {
      final budget =
          Budget(id: 1, label: 'Existing', amount: 100, envelopes: []);

      await budgetRepository.saveBudget(budget);

      verify(mockDb.updateBudget(budget)).called(1);
    });

    test('deleteEnvelope deletes the envelope', () async {
      final envelope =
          Envelope(id: 1, label: 'Test', amount: 100, operations: []);

      await budgetRepository.deleteEnvelope(envelope);

      verify(mockDb.delete(envelope)).called(1);
    });

    test('createNewBudget inserts a new budget', () {
      String label = 'Test';
      double amount = 100.0;
      budgetRepository.createNewBudget(
        label,
        amount,
      );

      verify(mockDb.insertBudget(any)).called(1);
    });

    test('deleteBudget deletes the budget', () {
      final budget = Budget(id: 1, label: 'Test', amount: 100, envelopes: []);

      budgetRepository.deleteBudget(budget);

      verify(mockDb.deleteBudget(budget)).called(1);
    });

    test('addEnvelope inserts a new envelope', () {
      final budget = Budget(id: 1, label: 'Test', amount: 100, envelopes: []);
      final label = 'New envelope';
      final amount = 100.0;

      budgetRepository.addEnvelope(
        budget,
        label,
        amount,
      );

      verify(
        mockDb.insertEnvelope(
          budgetId: budget.id,
          envelope: anyNamed('envelope'),
        ),
      ).called(1);
    });

    test('addOperation inserts a new operation', () async {
      final envelope =
          Envelope(id: 1, label: 'Test', amount: 100, operations: []);

      final label = 'New operation';
      final amount = 100.0;

      await budgetRepository.addOperation(envelope, label, amount);

      verify(
        mockDb.insertOperation(
          envelopeId: envelope.id,
          operation: anyNamed('operation'),
        ),
      ).called(1);
    });

    test('fetchEnvelope returns the envelope', () async {
      final envelope =
          Envelope(id: 1, label: 'Test', amount: 100, operations: []);
      when(mockDb.findEnvelope(1)).thenAnswer((_) async => envelope);

      final result = await budgetRepository.fetchEnvelope(1);

      expect(result, envelope);
      verify(mockDb.findEnvelope(1)).called(1);
    });

    test('editOperation updates the operation', () async {
      final operation =
          Operation(id: 1, label: 'Test', amount: 100, date: DateTime.now());

      await budgetRepository.editOperation(operation);

      verify(mockDb.updateOperation(operation)).called(1);
    });

    test('editEnvelope updates the envelope', () async {
      final envelope =
          Envelope(id: 1, label: 'Test', amount: 100, operations: []);

      await budgetRepository.editEnvelope(envelope);

      verify(mockDb.updateEnvelope(envelope)).called(1);
    });

    test('deleteOperation deletes the operation', () {
      final operation =
          Operation(id: 1, label: 'Test', amount: 100, date: DateTime.now());

      budgetRepository.deleteOperation(operation);

      verify(mockDb.deleteOperation(operation)).called(1);
    });
  });
}
