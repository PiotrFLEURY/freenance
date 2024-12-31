import 'package:flutter_test/flutter_test.dart';
import 'package:freenance/model/objects/envelope.dart';
import 'package:freenance/model/objects/operation.dart';

void main() {
  group('Remaining ratio', () {
    test('Remaining ratio is 0 when amount is 0', () {
      final envelope = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 0,
        operations: [],
      );
      expect(envelope.remainingRatio, 0);
    });

    test('Remaining ratio is 90 when amount is 100 and total operations is 10',
        () {
      final envelope = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [
          Operation(
            id: 1,
            label: 'Operation 1',
            amount: 10,
            date: DateTime.now(),
          ),
        ],
      );
      expect(envelope.remainingRatio, 0.9);
    });
  });

  group('Envelope tests', () {
    test('Remaining ratio is 0 when amount is 0', () {
      final envelope = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 0,
        operations: [],
      );
      expect(envelope.remainingRatio, 0);
    });

    test('Remaining ratio is 90 when amount is 100 and total operations is 10',
        () {
      final envelope = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [
          Operation(
            id: 1,
            label: 'Operation 1',
            amount: 10,
            date: DateTime.now(),
          ),
        ],
      );
      expect(envelope.remainingRatio, 0.9);
    });

    test('Total operations is correct', () {
      final envelope = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [
          Operation(
            id: 1,
            label: 'Operation 1',
            amount: 10,
            date: DateTime.now(),
          ),
          Operation(
            id: 2,
            label: 'Operation 2',
            amount: 20,
            date: DateTime.now(),
          ),
        ],
      );
      expect(envelope.totalOperations, 30);
    });

    test('Operation count is correct', () {
      final envelope = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [
          Operation(
            id: 1,
            label: 'Operation 1',
            amount: 10,
            date: DateTime.now(),
          ),
          Operation(
            id: 2,
            label: 'Operation 2',
            amount: 20,
            date: DateTime.now(),
          ),
        ],
      );
      expect(envelope.operationCount, 2);
    });

    test('Remaining amount is correct', () {
      final envelope = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [
          Operation(
            id: 1,
            label: 'Operation 1',
            amount: 10,
            date: DateTime.now(),
          ),
          Operation(
            id: 2,
            label: 'Operation 2',
            amount: 20,
            date: DateTime.now(),
          ),
        ],
      );
      expect(envelope.remainingAmount, 70);
    });

    test('Envelope fromMap creates correct instance', () {
      final map = {
        'id': 1,
        'label': 'Envelope 1',
        'amount': 100.0,
      };
      final envelope = Envelope.fromMap(map);
      expect(envelope.id, 1);
      expect(envelope.label, 'Envelope 1');
      expect(envelope.amount, 100.0);
      expect(envelope.operations, []);
    });

    test('Envelope toMap returns correct map', () {
      final envelope = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [],
      );
      final map = envelope.toMap();
      expect(map['id'], 1);
      expect(map['label'], 'Envelope 1');
      expect(map['amount'], 100);
    });

    test('Envelope equality operator returns true for identical envelopes', () {
      final envelope1 = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [],
      );
      final envelope2 = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [],
      );
      expect(envelope1 == envelope2, true);
    });

    test('Envelope equality operator returns false for different envelopes',
        () {
      final envelope1 = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [],
      );
      final envelope2 = Envelope(
        id: 2,
        label: 'Envelope 2',
        amount: 200,
        operations: [],
      );
      expect(envelope1 == envelope2, false);
    });

    test('Envelope hashCode is consistent with equality', () {
      final envelope1 = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [],
      );
      final envelope2 = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [],
      );
      expect(envelope1.hashCode, envelope2.hashCode);
    });

    test('Envelope hashCode is different for different envelopes', () {
      final envelope1 = Envelope(
        id: 1,
        label: 'Envelope 1',
        amount: 100,
        operations: [],
      );
      final envelope2 = Envelope(
        id: 2,
        label: 'Envelope 2',
        amount: 200,
        operations: [],
      );
      expect(envelope1.hashCode, isNot(envelope2.hashCode));
    });
  });
}
