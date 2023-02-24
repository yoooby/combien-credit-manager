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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                onPressed: () => onAlertPressed(context, db, store),
                shape: const CircleBorder(),
                constraints:
                    const BoxConstraints.tightFor(width: 40, height: 40),
                fillColor: kDarkColor,
                child: const Icon(
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
                  Text(AppLocalizations.of(context).spentThisWeek),
                  const SizedBox(
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
                        AppLocalizations.of(context).dh,
                        style: kCurrencyTextStyle.copyWith(color: kDarkColor),
                      )
                    ],
                  )
                ],
              ),
              TextButton(
                onPressed: () =>
                    onAlertPressed(context, db, store, isPayment: true),
                style: ButtonStyle(
                  // TODO: edit splash color
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(kDarkColor),
                ),
                child: Text(
                  AppLocalizations.of(context).pay,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
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

onAlertPressed(context, IsarService db, Store store, {bool isPayment = false}) {
  final amountController = TextEditingController();
  final descController = TextEditingController();
  Alert(
      context: context,
      title: isPayment
          ? AppLocalizations.of(context).pay
          : AppLocalizations.of(context).addTransaction,
      content: Form(
        child: Row(
          children: <Widget>[
            if (!isPayment) ...[
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).description,
                  ),
                ),
              ),
            ],
            const SizedBox(
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
                decoration: const InputDecoration(
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
                  amount: isPayment
                      ? -double.tryParse(amountController.text)!
                      : double.tryParse(amountController.text) ?? 0,
                  desc: descController.text);
              Navigator.pop(context);
            }
          },
          child: Text(
            AppLocalizations.of(context).add,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
