import 'package:isar/isar.dart';

part 'store.g.dart';

@collection
class Store {
  final Id id;
  late String name;
  late List<Transaction> transactionList = List.empty(growable: true);
  @ignore
  double get balance {
    double sum = 0;
    for (var transaction in transactionList) {
      sum += transaction.amount!;
    }
    return sum;
  }

  Store({
    required this.id,
    required this.name,
    required this.transactionList,
  });
}

@embedded
class Transaction {
  late String description;
  late double? amount;
  late DateTime? date;

  Transaction({
    this.description = '',
    this.amount,
    this.date,
  });
}
