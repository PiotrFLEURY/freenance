import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/model/objects/operation.dart';
import 'package:sqflite/sqflite.dart';

const String budgetTable = 'budget';
const String envelopeTable = 'envelope';
const String operationTable = 'operation';

const String createBudgetTable = '''
CREATE TABLE $budgetTable (
  id INTEGER PRIMARY KEY,
  label TEXT,
  amount REAL
)
''';

const String createEnvelopeTable = '''
CREATE TABLE $envelopeTable (
  id INTEGER PRIMARY KEY,
  label TEXT,
  amount REAL,
  budget_id INTEGER,
  FOREIGN KEY (budget_id) REFERENCES $budgetTable (id)
)
''';

const String createOperationTable = '''
CREATE TABLE $operationTable (
  id INTEGER PRIMARY KEY,
  label TEXT,
  amount REAL,
  date TEXT,
  envelope_id INTEGER,
  FOREIGN KEY (envelope_id) REFERENCES $envelopeTable (id)
)
''';

const String insertSampleBudget = '''
INSERT INTO $budgetTable (label, amount) VALUES ('Budget 1', 1000.0)
''';

const String insertSampleEnvelope = '''
INSERT INTO $envelopeTable (label, amount, budget_id) VALUES ('Envelope 1', 500.0, 1)
''';

const String insertSampleOperation = '''
INSERT INTO $operationTable (label, amount, date, envelope_id) 
VALUES ('Operation 1', 100.0, '2024-12-22 11:01:00', 1)
''';

class FreenanceDb {
  Completer<Database> dbCompleter = Completer();

  Future<void> init() async {
    // Initialize the database
    var databasesPath = await getDatabasesPath();
    var path = '$databasesPath/freenance.db';

    // Delete the database while debugging
    if (kDebugMode) {
      await deleteDatabase(path);
    }

    // open the database
    final openedDb = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(createBudgetTable);
        await db.execute(createEnvelopeTable);
        await db.execute(createOperationTable);
        if (kDebugMode) {
          await db.execute(insertSampleBudget);
          await db.execute(insertSampleEnvelope);
          await db.execute(insertSampleOperation);
        }
      },
    );

    dbCompleter.complete(openedDb);
  }

  Future<List<Budget>> findAllBudgets() async {
    final db = await dbCompleter.future;
    // Query the table for all the budgets
    final results = await db.query(budgetTable);
    final budgets = results.map((e) => Budget.fromMap(e)).toList();

    // For each budget, fetch its envelopes
    for (var budget in budgets) {
      final envelopes = await findEnvelopesByBudget(budget);
      budget.envelopes = envelopes;
    }

    return budgets;
  }

  Future<List<Envelope>> findEnvelopesByBudget(Budget budget) async {
    final db = await dbCompleter.future;
    final results = await db.query(
      envelopeTable,
      where: 'budget_id = ?',
      whereArgs: [budget.id],
    );

    final envelopes = results.map((e) => Envelope.fromMap(e)).toList();

    // For each envelope, fetch its operations
    for (var envelope in envelopes) {
      final operations = await findOperationsByEnvelope(envelope);
      envelope.operations = operations;
    }

    return envelopes;
  }

  Future<List<Operation>> findOperationsByEnvelope(Envelope envelope) async {
    final db = await dbCompleter.future;
    final results = await db.query(
      operationTable,
      where: 'envelope_id = ?',
      whereArgs: [envelope.id],
    );

    return results.map((e) => Operation.fromMap(e)).toList();
  }

  Future<void> insertBudget(Budget editedBudget) async {
    final db = await dbCompleter.future;
    await db.insert(budgetTable, editedBudget.toMap()..remove('id'));
  }

  Future<void> updateBudget(editedBudget) async {
    final db = await dbCompleter.future;
    await db.update(
      budgetTable,
      editedBudget.toMap(),
      where: 'id = ?',
      whereArgs: [editedBudget.id],
    );
  }

  Future<void> delete(Envelope envelope) async {
    final db = await dbCompleter.future;
    // Delete all operations for the envelope
    await db.delete(
      operationTable,
      where: 'envelope_id = ?',
      whereArgs: [envelope.id],
    );

    // Delete the envelope
    await db.delete(
      envelopeTable,
      where: 'id = ?',
      whereArgs: [envelope.id],
    );
  }

  void deleteBudget(Budget budget) {
    // Delete all envelopes for the budget
    for (var envelope in budget.envelopes) {
      delete(envelope);
    }

    // Delete the budget
    final db = dbCompleter.future;
    db.then((db) {
      db.delete(
        budgetTable,
        where: 'id = ?',
        whereArgs: [budget.id],
      );
    });
  }

  void insertEnvelope({required int budgetId, required Envelope envelope}) {
    final db = dbCompleter.future;
    db.then((db) {
      db.insert(
        envelopeTable,
        envelope.toMap()
          ..remove('id')
          ..['budget_id'] = budgetId,
      );
    });
  }

  Future<void> insertOperation({
    required int envelopeId,
    required Operation operation,
  }) async {
    final db = await dbCompleter.future;
    await db.insert(
      operationTable,
      operation.toMap()
        ..remove('id')
        ..['envelope_id'] = envelopeId,
    );
  }

  Future<Envelope> findEnvelope(int envelopeId) async {
    final db = await dbCompleter.future;
    final results = await db.query(
      envelopeTable,
      where: 'id = ?',
      whereArgs: [envelopeId],
    );

    final envelope = Envelope.fromMap(results.first);

    final operations = await findOperationsByEnvelope(envelope);
    envelope.operations = operations;

    return envelope;
  }

  Future<void> updateOperation(Operation operation) async {
    final db = await dbCompleter.future;
    await db.update(
      operationTable,
      operation.toMap(),
      where: 'id = ?',
      whereArgs: [operation.id],
    );
  }

  Future<void> updateEnvelope(Envelope envelope) async {
    final db = await dbCompleter.future;
    await db.update(
      envelopeTable,
      envelope.toMap(),
      where: 'id = ?',
      whereArgs: [envelope.id],
    );
  }

  Future<void> deleteOperation(Operation operation) async {
    final db = await dbCompleter.future;
    await db.delete(
      operationTable,
      where: 'id = ?',
      whereArgs: [operation.id],
    );
  }
}
