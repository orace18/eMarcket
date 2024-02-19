class Wallet {
  double balance;
  List<Transaction> transactions;

  Wallet({required this.balance, required this.transactions});
}

class Transaction {
  String description;
  double amount;
  DateTime date;

  Transaction({required this.description, required this.amount, required this.date});
}
