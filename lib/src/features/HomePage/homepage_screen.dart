// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constans/ui_constants.dart';
import '../stores/store_card.dart';
import 'homepage_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          StoreCard(),
          StoreCard(),
          StoreCard(),
          StoreCard(),
          StoreCard(),
          StoreCard(),
          StoreCard(),
        ],
      ),
    );
  }
}
