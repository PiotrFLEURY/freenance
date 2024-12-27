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
}
