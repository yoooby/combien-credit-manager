// ignore_for_file: prefer_const_constructors

import 'package:combien/src/models/dtos/store.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../database.dart';
import '../utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreCard extends StatelessWidget {
  const StoreCard(
      {super.key,
      required this.store,
      required this.amount,
      this.onPress,
      required this.db,
      required this.parentContext});
  final BuildContext parentContext;
  final Store store;
  final IsarService db;
  final String amount;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    TapDownDetails? tapPos;
    return Container(
      padding: EdgeInsets.all(0),
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTapDown: (details) => tapPos = details,
        onLongPress: () => showMenu(
          context: context,
          items: [
            PopupMenuItem(
                child: Text(AppLocalizations.of(context).edit),
                onTap: () {
                  Future.delayed(
                    Duration(seconds: 0),
                    () => onEditAlertPressed(context, db, store),
                  );
                }),
            PopupMenuItem(
              child: Text(AppLocalizations.of(context).delete),
              onTap: () {
                db.deleteStore(store.id);
              },
            ),
          ],
          position: RelativeRect.fromLTRB(
              tapPos!.globalPosition.dx, tapPos!.globalPosition.dy, 0, 0),
        ),
        onTap: onPress,
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
                  store.name,
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
                      amount,
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
                      AppLocalizations.of(context).dh,
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

onEditAlertPressed(context, IsarService db, Store store) {
  final nameController = TextEditingController(text: store.name);
  Alert(
      context: context,
      title: AppLocalizations.of(context).edit,
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
            db.editStore(store.id, nameController.text);
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context).edit,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
