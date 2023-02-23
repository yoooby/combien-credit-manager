// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:combien/src/components/store_transactions_list.dart';
import 'package:combien/src/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/dtos/store.dart';
import '../providers/stores_provider.dart';
import '../utils/constants.dart';

class StorePage extends ConsumerWidget {
  const StorePage({super.key, required this.store});
  final Store store;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(isarProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RawMaterialButton(
                elevation: 0,
                onPressed: () => onAddAlertPressed(context, db, store),
                shape: CircleBorder(),
                constraints: BoxConstraints.tightFor(width: 40, height: 40),
                fillColor: kDarkColor,
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          foregroundColor: kDarkColor,
          title: Text(store.name),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Total amount
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Spent this week'),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final balance =
                              ref.watch(storeBalanceProvider(store.id).stream);
                          return StreamBuilder(
                            stream: balance,
                            initialData: store.balance,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return Text(
                                snapshot.data.toString(),
                                style: kCardTextStyle.copyWith(
                                    color: kDarkColor,
                                    fontWeight: FontWeight.w600),
                              );
                            },
                          );
                        },
                      ),
                      Text(
                        'DH',
                        style: kCurrencyTextStyle.copyWith(color: kDarkColor),
                      )
                    ],
                  )
                ],
              ),
              TextButton(
                onPressed: () => {},
                style: ButtonStyle(
                  // TODO: edit splash color
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(kDarkColor),
                ),
                child: const Text(
                  'Pay',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: TransactionsList(store)),
            ],
          ),
        ),
      ),
    );
  }
}

onAddAlertPressed(context, IsarService db, Store store) {
  final amountController = TextEditingController();
  final descController = TextEditingController();
  Alert(
      context: context,
      title: "Add transaction",
      content: Form(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: 'Description (optional)',
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                ],
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'amount',
                ),
              ),
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          color: kDarkColor,
          onPressed: () {
            if (amountController.text.isNotEmpty) {
              db.addTransaction(
                  storeId: store.id,
                  amount: double.tryParse(amountController.text) ?? 0,
                  desc: descController.text);
              Navigator.pop(context);
            }
          },
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
