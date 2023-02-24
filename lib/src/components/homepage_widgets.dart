
import 'package:combien/src/providers/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/constants.dart';

class BalanceCard extends ConsumerWidget {
  const BalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(totalAmountProvider.stream);
    return Container(
      margin: const EdgeInsets.all(15.0),
      width: double.infinity,
      height: 230,
      child: Card(
        elevation: 8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: const Color(0xFF0396FA),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                StreamBuilder(
                  stream: balance,
                  initialData: 0,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Text(
                      snapshot.data.toInt().toString(),
                      style: kCardTextStyle,
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context).dh,
                  style: kCurrencyTextStyle,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(AppLocalizations.of(context).finance, style: kAppBarTextStyle),
        Text(
          AppLocalizations.of(context).settings,
          style: kAppBarTextStyle,
        ),
      ],
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({
    super.key,
    required this.icon,
    this.label = '',
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          elevation: 2,
          onPressed: onPressed,
          shape: const CircleBorder(),
          constraints: const BoxConstraints.tightFor(width: 56, height: 56),
          fillColor: kDarkColor,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: kDarkColor,
          ),
        ),
      ],
    );
  }
}
