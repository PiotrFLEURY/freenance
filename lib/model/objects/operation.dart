class Operation {
  Operation({
    required this.id,
    required this.label,
    required this.amount,
    required this.date,
  });

  int id;
  String label;
  double amount;
  DateTime date;

  static Operation fromMap(Map<String, Object?> e) {
    return Operation(
      id: e['id'] as int,
      label: e['label'] as String,
      amount: e['amount'] as double,
      date: DateTime.parse(e['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
