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

  void createNewBudget(String label, double amount) {
    db.insertBudget(
      Budget(
        id: 0,
        label: label,
        amount: amount,
        envelopes: List.empty(),
      ),
    );
  }

  void deleteBudget(Budget budget) {
    db.deleteBudget(budget);
  }

  void addEnvelope(Budget budget, String label, double amount) {
    db.insertEnvelope(
      budgetId: budget.id,
      envelope: Envelope(
        id: 0,
        label: label,
        amount: amount,
        operations: List.empty(),
      ),
    );
  }

  Future<void> addOperation(
    Envelope envelope,
    String label,
    double amount,
  ) async {
    await db.insertOperation(
      envelopeId: envelope.id,
      operation: Operation(
        id: 0,
        label: label,
        amount: amount,
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
