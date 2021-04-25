import 'package:flutter/material.dart';
import 'package:gostcoin_wallet_flutter/generated/i18n.dart';
import 'package:gostcoin_wallet_flutter/screens/contacts/widgets/contact_tile.dart';
import 'package:gostcoin_wallet_flutter/utils/format.dart';
import 'package:gostcoin_wallet_flutter/utils/send.dart';

class SendToAccount extends StatelessWidget {
  final String accountAddress;
  final VoidCallback resetSearch;
  const SendToAccount({Key key, this.accountAddress, this.resetSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        ContactTile(
          displayName: formatAddress(accountAddress),
          onTap: () {
            resetSearch();
            sendToPastedAddress(accountAddress);
          },
          trailing: InkWell(
            child: Text(
              I18n.of(context).next_button,
              style: TextStyle(color: Color(0xFF0377FF)),
            ),
            onTap: () {
              resetSearch();
              sendToPastedAddress(accountAddress);
            },
          ),
        )
      ]),
    );
  }
}
