// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:isar/isar.dart';
// part 'transactions.freezed.dart';

// @freezed
// class Store with _$Store {
//   double get balance {
//     double sum = 0;
//     for (var transation in transactionList) {
//       sum += transation.amount;
//     }
//     return sum;
//   }

//   const Store._();

//   const factory Store({
//     required Id id,
//     required final String name,
//     required final List<Transaction> transactionList,
//   }) = _Store;
// }

// @freezed
// abstract class Transaction with _$Transaction {
//   const factory Transaction({
//     required String description,
//     required double amount,
//     required DateTime date,
//   }) = _Transaction;
// }
