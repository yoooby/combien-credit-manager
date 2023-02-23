import 'dart:math';

import 'package:combien/src/models/dtos/store.dart';
import 'package:combien/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../providers/stores_provider.dart';

class TransactionsList extends ConsumerWidget {
  final Store store;

  const TransactionsList(this.store, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsList = ref.watch(transactionsListProvider(store).stream);
    print(transactionsList.toList().toString());
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: StreamBuilder(
        stream: transactionsList,
        initialData: store.transactionList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return GroupedListView<Transaction, DateTime?>(
            elements: snapshot.data,
            groupBy: (Transaction element) => DateTime(
              element.date!.year,
              element.date!.month,
              element.date!.day,
            ),
            groupSeparatorBuilder: (DateTime? groupByValue) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 35,
                    width: 125,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      color: kDarkColor,
                    ),
                    child: Center(
                        child: Text(
                      Jiffy(groupByValue).yMEd,
                      style: TextStyle(color: Colors.white),
                    ))),
              ],
            ),
            itemBuilder: _getItem,
            controller: ScrollController(),
            useStickyGroupSeparators: true, // optional
            floatingHeader: true, // optional
            order: GroupedListOrder.DESC, // optional
          );
        },
      ),
    );
  }
}

const kTransactionListTextStyle =
    TextStyle(fontWeight: FontWeight.w600, color: kDarkColor, fontSize: 20);

Widget _getItem(BuildContext ctx, Transaction element) {
  return SizedBox(
    height: 70,
    child: Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (element.description.isNotEmpty) ...[
                  Text(
                    element.description,
                    style: kTransactionListTextStyle,
                  ),
                ],
                Align(
                  child: Text(
                    Jiffy(element.date).jm,
                    textAlign: TextAlign.start,
                    style: element.description.isNotEmpty
                        ? TextStyle()
                        : kTransactionListTextStyle.copyWith(
                            color: kDarkColor.withOpacity(.7)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  element.amount.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kDarkColor,
                      fontSize: 20),
                ),
                Text(
                  "DH",
                  style: TextStyle(
                      color: kDarkColor.withOpacity(.8), fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _getGroupSeparator(DateTime? date) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Jiffy(date).EEEE),
            Text(Jiffy(date).yMMMd),
          ],
        ),
        const Divider(
          color: kDarkColor,
        ),
      ],
    ),
  );
}
