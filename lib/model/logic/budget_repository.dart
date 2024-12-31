import 'package:freenance/model/logic/freenance_db.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/model/objects/operation.dart';

class BudgetRepository {
  BudgetRepository(this.db);

  final FreenanceDb db;

  Future<List<Budget>> fetchBudgets() async {
    return db.findAllBudgets();
  }

  Future<void> saveBudget(Budget editedBudget) async {
    if (editedBudget.id == 0) {
      await db.insertBudget(editedBudget);
    } else {
      await db.updateBudget(editedBudget);
    }
  }

  Future<void> deleteEnvelope(Envelope envelope) async {
    await db.delete(envelope);
  }

  void createNewBudget() {
    db.insertBudget(
      Budget(
        id: 0,
        label: 'New budget',
        amount: 0,
        envelopes: List.empty(),
      ),
    );
  }

  void deleteBudget(Budget budget) {
    db.deleteBudget(budget);
  }

  void addEnvelope(Budget budget) {
    db.insertEnvelope(
      budgetId: budget.id,
      envelope: Envelope(
        id: 0,
        label: 'New envelope',
        amount: 0,
        operations: List.empty(),
      ),
    );
  }

  Future<void> addOperation(Envelope envelope) async {
    await db.insertOperation(
      envelopeId: envelope.id,
      operation: Operation(
        id: 0,
        label: 'New operation',
        amount: 0,
        date: DateTime.now(),
      ),
    );
  }

  Future<Envelope> fetchEnvelope(int envelopeId) {
    return db.findEnvelope(envelopeId);
  }

  Future<void> editOperation(Operation operation) async {
    await db.updateOperation(operation);
  }

  Future<void> editEnvelope(Envelope envelope) async {
    await db.updateEnvelope(envelope);
  }

  void deleteOperation(Operation operation) {
    db.deleteOperation(operation);
  }
}
