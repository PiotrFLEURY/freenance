import 'package:flutter_test/flutter_test.dart';
import 'package:freenance/model/objects/budget.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/model/objects/operation.dart';

/// Test the budget model
void main() {
  /// Test the totalEnvelopeOperations getter
  group('totalEnvelopeOperations', () {
    test('totalEnvelopeOperations should be zero when no envelopes', () {
      // GIVEN
      final Budget budget = Budget(
        id: 1,
        label: 'Test',
        amount: 100,
        envelopes: [],
      );

      // WHEN
      final double totalEnvelopeOperations = budget.totalEnvelopeOperations;

      // THEN
      expect(totalEnvelopeOperations, 0);
    });
    test('totalEnvelopeOperations should be equal to envelope total sum', () {
      // GIVEN
      final Budget budget = Budget(
        id: 1,
        label: 'Test',
        amount: 100,
        envelopes: [
          Envelope(
            id: 1,
            label: 'Test',
            amount: 50,
            operations: [
              Operation(
                id: 1,
                label: 'Test',
                amount: 10,
                date: DateTime.now(),
              ),
              Operation(
                id: 2,
                label: 'Test',
                amount: 20,
                date: DateTime.now(),
              ),
            ],
          ),
          Envelope(
            id: 2,
            label: 'Test',
            amount: 50,
            operations: [
              Operation(
                id: 3,
                label: 'Test',
                amount: 30,
                date: DateTime.now(),
              ),
              Operation(
                id: 4,
                label: 'Test',
                amount: 40,
                date: DateTime.now(),
              ),
            ],
          ),
        ],
      );

      // WHEN
      final double totalEnvelopeOperations = budget.totalEnvelopeOperations;

      // THEN
      expect(totalEnvelopeOperations, 100);
    });
  });

  /// Test the remainingAmount getter
  group('remainingAmount', () {
    test('remainingAmount should be equal to amount when no envelopes', () {
      // GIVEN
      final Budget budget = Budget(
        id: 1,
        label: 'Test',
        amount: 100,
        envelopes: [],
      );

      // WHEN
      final double remainingAmount = budget.remainingAmount;

      // THEN
      expect(remainingAmount, 100);
    });

    test(
        'remainingAmount should be equal to amount minus totalEnvelopeOperations',
        () {
      // GIVEN
      final Budget budget = Budget(
        id: 1,
        label: 'Test',
        amount: 100,
        envelopes: [
          Envelope(
            id: 1,
            label: 'Test',
            amount: 50,
            operations: [
              Operation(
                id: 1,
                label: 'Test',
                amount: 10,
                date: DateTime.now(),
              ),
              Operation(
                id: 2,
                label: 'Test',
                amount: 20,
                date: DateTime.now(),
              ),
            ],
          ),
        ],
      );

      // WHEN
      final double remainingAmount = budget.remainingAmount;

      // THEN
      expect(remainingAmount, 70);
    });
  });

  /// Test the remainingRatio getter
  group('remainingRatio', () {
    test('remainingRatio should be zero when amount is zero', () {
      // GIVEN
      final Budget budget = Budget(
        id: 1,
        label: 'Test',
        amount: 0,
        envelopes: [],
      );

      // WHEN
      final double remainingRatio = budget.remainingRatio;

      // THEN
      expect(remainingRatio, 0);
    });

    test('remainingRatio should be 100 when no envelopes', () {
      // GIVEN
      final Budget budget = Budget(
        id: 1,
        label: 'Test',
        amount: 100,
        envelopes: [],
      );

      // WHEN
      final double remainingRatio = budget.remainingRatio;

      // THEN
      expect(remainingRatio, 100);
    });

    test('remainingRatio should be correct when envelopes are present', () {
      // GIVEN
      final Budget budget = Budget(
        id: 1,
        label: 'Test',
        amount: 100,
        envelopes: [
          Envelope(
            id: 1,
            label: 'Test',
            amount: 50,
            operations: [
              Operation(
                id: 1,
                label: 'Test',
                amount: 10,
                date: DateTime.now(),
              ),
              Operation(
                id: 2,
                label: 'Test',
                amount: 20,
                date: DateTime.now(),
              ),
            ],
          ),
        ],
      );

      // WHEN
      final double remainingRatio = budget.remainingRatio;

      // THEN
      expect(remainingRatio, 70);
    });
  });

  /// Test the fromMap method
  group('fromMap', () {
    test('fromMap should create a Budget object from a map', () {
      // GIVEN
      final Map<String, Object?> map = {
        'id': 1,
        'label': 'Test',
        'amount': 100.0,
      };

      // WHEN
      final Budget budget = Budget.fromMap(map);

      // THEN
      expect(budget.id, 1);
      expect(budget.label, 'Test');
      expect(budget.amount, 100.0);
      expect(budget.envelopes, []);
    });
  });

  /// Test the toMap method
  group('toMap', () {
    test('toMap should create a map from a Budget object', () {
      // GIVEN
      final Budget budget = Budget(
        id: 1,
        label: 'Test',
        amount: 100,
        envelopes: [],
      );

      // WHEN
      final Map<String, Object?> map = budget.toMap();

      // THEN
      expect(map['id'], 1);
      expect(map['label'], 'Test');
      expect(map['amount'], 100.0);
    });
  });
}
