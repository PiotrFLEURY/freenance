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

  double get totalEnvelopeOperations {
    return envelopes.fold<double>(
      0,
      (previousValue, element) => previousValue + element.totalOperations,
    );
  }

  double get remainingAmount {
    return amount - totalEnvelopeOperations;
  }

  double get remainingRatio {
    if (amount == 0) {
      return 0;
    }
    final onePercent = amount / 100;
    final remainingPercentage = remainingAmount / onePercent;
    return remainingPercentage;
  }

  bool get envelopesAmountTooHigh {
    return totalEnvelopes > amount;
  }

  double get totalEnvelopes {
    return envelopes.fold<double>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
  }

  double get envelopesAmountExcedent {
    return totalEnvelopes - amount;
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

  Budget copyWith({required String label, required double amount}) {
    return Budget(
      id: id,
      label: label,
      amount: amount,
      envelopes: envelopes,
    );
  }
}
