import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/transactions.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final totalAmount = Provider<double>((ref) {
  return ref
      .watch(storesListProvider)
      .map((e) => e.balance)
      .reduce((a, b) => a + b);
});

final storesListProvider =
    StateNotifierProvider<StoresNotifier, List<Store>>((ref) {
  return StoresNotifier([
    Store(name: 'ismailia :)', transactionList: []),
    Store(name: 'SK', transactionList: []),
  ]);
});

class StoresNotifier extends StateNotifier<List<Store>> {
  StoresNotifier([List<Store>? initialStores]) : super(initialStores ?? []);

  /// Adds `Store` item to list.
  void add(String name) {
    state = [
      ...state,
      Store(
        name: name,
        transactionList: const [],
      ),
    ];
  }

  /// Edits a `Store` item.
  void edit({required String id, required String name}) {
    final newState = [...state];
    final storeToReplaceIndex = state.indexWhere((store) => store.id == id);

    if (storeToReplaceIndex != -1) {
      newState[storeToReplaceIndex] =
          state[storeToReplaceIndex].copyWith(name: name);
    }
    state = newState;
  }
}
