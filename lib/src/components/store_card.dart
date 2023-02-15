// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/ui_constants.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          color: Color(0xFFF2F4F5),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Test Ismailia',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kDarkColor,
                  ),
                ),
                Row(
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      '50',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kDarkColor,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'DH',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}