class Transaction {
  String id;
  String userId;
  String transactionId;
  String type;
  double amount;
  String date;
  String createdAt;
  String updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.type,
    required this.amount, // Changement ici
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      userId: json['userId'],
      transactionId: json['transactionId'],
      type: json['type'],
      amount: json['amount'].toDouble(), 
      date: json['date'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
