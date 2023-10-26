class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });
}

class Verba {
  final String id;
  final double value;

  Verba({
    required this.id,
    required this.value,
  });
}

class Meta {
  final String id;
  final double value;

  Meta({
    required this.id,
    required this.value,
  });
}