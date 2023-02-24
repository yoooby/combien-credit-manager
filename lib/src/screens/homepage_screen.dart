
import 'package:combien/src/database.dart';
import 'package:combien/src/models/dtos/store.dart';
import 'package:combien/src/providers/stores_provider.dart';
import 'package:combien/src/screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/store_card.dart';
import '../components/homepage_widgets.dart';
import '../utils/constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.read(storesListProvider.stream);
    final db = ref.read(isarProvider);
    return SafeArea(
      child: Column(
        children: <Widget>[
          // home app bar
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: MyAppBar(),
          // ),
          const BalanceCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomePageButton(
                label: AppLocalizations.of(context).statistics,
                icon: FontAwesomeIcons.chartPie,
              ),
              HomePageButton(
                label: AppLocalizations.of(context).add,
                onPressed: () => onAddAlertPressed(context, db),
                icon: FontAwesomeIcons.plus,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<List<Store>>(
            stream: stores,
            initialData: List.empty(growable: true),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator.adaptive();
              } else {
                return Column(
                  children: [
                    for (var store in snapshot.data)
                      StoreCard(
                        parentContext: context,
                        db: db,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StorePage(store: store),
                            ),
                          );
                        },
                        store: store,
                        amount: store.balance.toString(),
                      ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

onAddAlertPressed(context, IsarService db) {
  final nameController = TextEditingController();
  Alert(
      context: context,
      title: AppLocalizations.of(context).addStore,
      content: Form(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).name,
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
            db.createStore(nameController.text);
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context).add,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
