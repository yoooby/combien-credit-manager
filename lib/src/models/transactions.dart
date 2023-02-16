import 'package:freezed_annotation/freezed_annotation.dart';
part 'transactions.freezed.dart';

@freezed
class Store with _$Store {
  const factory Store({
    required final String name,
    required final List<Transaction> transactionList,
  }) = _Store;
}

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required String description,
    required double amount,
  }) = _Transaction;
}