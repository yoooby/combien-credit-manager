import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:combien/src/models/dtos/store.dart';
import 'package:isar/isar.dart';

import '../database.dart';

final transactionsListProvider =
    StreamProvider.family<List<Transaction>, Store>((ref, store) async* {
  final storeList = await ref.watch(storesListProvider.future);
  final newStore = storeList.where((element) => store.id == element.id).first;
  yield newStore.transactionList;
});

final storeBalanceProvider =
    StreamProvider.family<double, Id>((ref, storeId) async* {
  final storeList = await ref.watch(storesListProvider.future);
  final store = storeList.where((store) => storeId == store.id).first;
  yield store.balance;
});

final totalAmountProvider = StreamProvider<double>((ref) async* {
  final storesList = await ref.watch(storesListProvider.future);
  yield storesList.map((store) => store.balance).fold(0.0, (a, b) => a + b);
});

final storesListProvider = StreamProvider<List<Store>>((ref) async* {
  final storesList = ref.watch(isarProvider).getAllStores();
  yield* storesList;
});
// class StoresNotifier extends StateNotifier<List<Store>> {
//   final List<Store> initialStores;

//   StoresNotifier(this.initialStores) : super(initialStores =) {

//   };

//   Future<Void> getStores(IsarService isar) async {
//     initialStores = await isar
//         .getAllStores()
//         .then((value) => value.map((e) => e.toDomain()).toList());
//     throw 'Done';
//   }

//   /// Adds `Store` item to list.
//   void add(String name) {
//     state = [
//       ...state,
//       Store(
//         id: Isar.autoIncrement,
//         name: name,
//         transactionList: const [],
//       ),
//     ];
//   }

//   /// Edits a `Store` item.
//   void edit({required String id, required String name}) {
//     final newState = [...state];
//     final storeToReplaceIndex = state.indexWhere((store) => store.id == id);

//     if (storeToReplaceIndex != -1) {
//       newState[storeToReplaceIndex] =
//           state[storeToReplaceIndex].copyWith(name: name);
//     }
//     state = newState;
//   }
// }
