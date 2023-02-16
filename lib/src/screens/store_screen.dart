// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/homepage_widgets.dart';
import '../models/transactions.dart';
import '../utils/constants.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key, required this.store});
  final Store store;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RawMaterialButton(
                elevation: 0,
                onPressed: () {},
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
                      Text(
                        store.balance.toString(),
                        style: kCardTextStyle.copyWith(
                            color: kDarkColor, fontWeight: FontWeight.w600),
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
                onPressed: () {},
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
              // TODO: implement list of transactions
              // ListView(
              //   // t
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
