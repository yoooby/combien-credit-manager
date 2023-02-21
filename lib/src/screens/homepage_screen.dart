// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:combien/src/models/dtos/store.dart';
import 'package:combien/src/models/transactions.dart';
import 'package:combien/src/providers/stores_provider.dart';
import 'package:combien/src/screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/store_card.dart';
import '../components/homepage_widgets.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.read(storesListProvider.stream);

    return SafeArea(
      child: Column(
        children: <Widget>[
          // home app bar
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyAppBar(),
          ),
          BalanceCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomePageButton(
                label: 'Statistics',
                icon: FontAwesomeIcons.chartPie,
              ),
              HomePageButton(
                label: 'Add',
                icon: FontAwesomeIcons.plus,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          StreamBuilder<List<Store>>(
            stream: stores,
            initialData: List.empty(growable: true),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator.adaptive();
              } else {
                return Column(
                  children: [
                    for (var store in snapshot.data)
                      StoreCard(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StorePage(store: store),
                            ),
                          );
                        },
                        name: store.name,
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
