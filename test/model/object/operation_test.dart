import 'package:flutter_test/flutter_test.dart';
import 'package:freenance/model/objects/operation.dart';

void main() {
  group('Operation', () {
    test('fromMap creates an Operation from a map', () {
      final map = {
        'id': 1,
        'label': 'Test Operation',
        'amount': 100.0,
        'date': '2023-10-01T00:00:00.000Z',
      };

      final operation = Operation.fromMap(map);

      expect(operation.id, 1);
      expect(operation.label, 'Test Operation');
      expect(operation.amount, 100.0);
      expect(operation.date, DateTime.parse('2023-10-01T00:00:00.000Z'));
    });

    test('toMap converts an Operation to a map', () {
      final operation = Operation(
        id: 1,
        label: 'Test Operation',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      final map = operation.toMap();

      expect(map['id'], 1);
      expect(map['label'], 'Test Operation');
      expect(map['amount'], 100.0);
      expect(map['date'], '2023-10-01T00:00:00.000Z');
    });

    test('equality of two Operation objects', () {
      final operation1 = Operation(
        id: 1,
        label: 'Test Operation',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      final operation2 = Operation(
        id: 1,
        label: 'Test Operation',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      expect(operation1, equals(operation2));
    });

    test('inequality of two Operation objects', () {
      final operation1 = Operation(
        id: 1,
        label: 'Test Operation 1',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      final operation2 = Operation(
        id: 2,
        label: 'Test Operation 2',
        amount: 200.0,
        date: DateTime.parse('2023-10-02T00:00:00.000Z'),
      );

      expect(operation1, isNot(equals(operation2)));
    });

    test('== operator returns true for identical objects', () {
      final operation1 = Operation(
        id: 1,
        label: 'Test Operation',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      final operation2 = Operation(
        id: 1,
        label: 'Test Operation',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      expect(operation1 == operation2, isTrue);
    });

    test('== operator returns false for different objects', () {
      final operation1 = Operation(
        id: 1,
        label: 'Test Operation 1',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      final operation2 = Operation(
        id: 2,
        label: 'Test Operation 2',
        amount: 200.0,
        date: DateTime.parse('2023-10-02T00:00:00.000Z'),
      );

      expect(operation1 == operation2, isFalse);
    });

    test('hashCode returns the same value for identical objects', () {
      final operation1 = Operation(
        id: 1,
        label: 'Test Operation',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      final operation2 = Operation(
        id: 1,
        label: 'Test Operation',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      expect(operation1.hashCode, operation2.hashCode);
    });

    test('hashCode returns different values for different objects', () {
      final operation1 = Operation(
        id: 1,
        label: 'Test Operation 1',
        amount: 100.0,
        date: DateTime.parse('2023-10-01T00:00:00.000Z'),
      );

      final operation2 = Operation(
        id: 2,
        label: 'Test Operation 2',
        amount: 200.0,
        date: DateTime.parse('2023-10-02T00:00:00.000Z'),
      );

      expect(operation1.hashCode, isNot(operation2.hashCode));
    });
  });
}
