import 'package:freenance/model/objects/envelope.dart';

class Budget {
  Budget({
    required this.id,
    required this.label,
    required this.amount,
    required this.envelopes,
  });

  int id;
  String label;
  double amount;
  List<Envelope> envelopes;

  get totalEnvelopeOperations {
    return envelopes.fold<double>(
      0,
      (previousValue, element) => previousValue + element.totalOperations,
    );
  }

  get remainingAmount {
    return amount - totalEnvelopeOperations;
  }

  get remainingRatio {
    if (amount == 0) {
      return 0;
    }
    final onePercent = amount / 100;
    final remainingPercentage = remainingAmount / onePercent;
    return remainingPercentage;
  }

  static Budget fromMap(Map<String, Object?> e) {
    return Budget(
      id: e['id'] as int,
      label: e['label'] as String,
      amount: e['amount'] as double,
      envelopes: [],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'label': label,
      'amount': amount,
    };
  }
}
