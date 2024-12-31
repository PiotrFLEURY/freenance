import 'package:freenance/model/objects/operation.dart';

class Envelope {
  Envelope({
    required this.id,
    required this.label,
    required this.amount,
    required this.operations,
  });

  int id;
  String label;
  double amount;
  List<Operation> operations;

  double get totalOperations {
    return operations.fold<double>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
  }

  int get operationCount {
    return operations.length;
  }

  double get remainingAmount {
    return amount - totalOperations;
  }

  double get remainingRatio => amount > 0 ? remainingAmount / amount : 0;

  static Envelope fromMap(Map<String, Object?> e) {
    return Envelope(
      id: e['id'] as int,
      label: e['label'] as String,
      amount: e['amount'] as double,
      operations: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'amount': amount,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Envelope &&
        other.id == id &&
        other.label == label &&
        other.amount == amount;
  }

  @override
  int get hashCode => id.hashCode ^ label.hashCode ^ amount.hashCode;
}
