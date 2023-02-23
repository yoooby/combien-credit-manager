import 'dart:io';

import 'package:combien/src/models/dtos/store.dart';
import 'package:combien/src/models/transactions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart';

final isarProvider = Provider<IsarService>((ref) {
  return IsarService();
});

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [StoreSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> createStore(String storeName) async {
    final isar = await db;
    final newStore = Store(
        id: Isar.autoIncrement,
        name: storeName,
        transactionList: List.empty(growable: true));
    isar.writeTxnSync<int>(() => isar.stores.putSync(newStore));
  }

  Future<void> addTransaction(
      {required Id storeId, required double amount, String desc = ''}) async {
    final isar = await db;
    Store? store = await isar.stores.get(storeId);
    final transaction =
        Transaction(amount: amount, date: DateTime.now(), description: desc);
    // work around since for some reason lists are not growable
    List<Transaction> tsList = store!.transactionList;
    store.transactionList = List.empty(growable: true);
    store.transactionList.addAll(tsList);
    store.transactionList.add(transaction);
    await isar.writeTxn(() async {
      for (var i in store.transactionList) {
        print(i.date);
      }
      await isar.stores.put(store);
    });
  }

  Stream<List<Store>> getAllStores() async* {
    final isar = await db;
    yield* isar.stores.where().sortByName().watch(fireImmediately: true);
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }
}
