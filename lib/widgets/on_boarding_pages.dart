import 'package:flutter/material.dart';
import 'package:gostcoin_wallet_flutter/generated/i18n.dart';
import 'package:gostcoin_wallet_flutter/screens/splash/create_wallet.dart';

Widget introPage(BuildContext context, String title, String subTitle, String gostCoinCoreStatusLabelText) {
  return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                gostCoinCoreStatusLabelText,
                style:
                TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary,),
                textAlign: TextAlign.center,
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                subTitle,
                style:
                    TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary,),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
}

List<Widget> getPages(BuildContext context) {
  var gostCoinCoreStatusLabelText = I18n.of(context).gostCoinCoreStatusLabelText;
  return <Widget>[
    introPage(context, I18n.of(context).simple, I18n.of(context).intro_text_one, gostCoinCoreStatusLabelText),
    introPage(context, I18n.of(context).useful, I18n.of(context).intro_text_two, gostCoinCoreStatusLabelText),
    introPage(context, I18n.of(context).smart, I18n.of(context).intro_text_three, gostCoinCoreStatusLabelText),
    CreateWallet()
  ];
}
