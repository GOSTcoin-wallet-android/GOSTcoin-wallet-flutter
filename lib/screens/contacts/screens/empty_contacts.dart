import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gostcoin_wallet_flutter/generated/i18n.dart';
import 'package:gostcoin_wallet_flutter/models/app_state.dart';
import 'package:gostcoin_wallet_flutter/models/views/contacts.dart';
import 'package:gostcoin_wallet_flutter/screens/contacts/screens/send_to_account.dart';
import 'package:gostcoin_wallet_flutter/screens/contacts/widgets/enable_contacts.dart';
import 'package:gostcoin_wallet_flutter/screens/contacts/router/router_contacts.gr.dart';
import 'package:gostcoin_wallet_flutter/screens/contacts/widgets/search_panel.dart';
import 'package:gostcoin_wallet_flutter/widgets/main_scaffold.dart';
import "package:ethereum_address/ethereum_address.dart";

class EmptyContacts extends StatefulWidget {
  @override
  _EmptyContactsState createState() => _EmptyContactsState();
}

class _EmptyContactsState extends State<EmptyContacts> {
  bool showFooter = true;
  bool hasSynced = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void resetSearch() {
    FocusScope.of(context).unfocus();
    if (mounted) {
      setState(() {
        searchController.text = '';
      });
    }
  }
  List<Widget> _buildPageList(ContactsViewModel viewModel) {
    List<Widget> listItems = List();

    listItems.add(SearchPanel(
      searchController: searchController,
    ));

    if (isValidEthereumAddress(searchController.text)) {
      listItems.add(SendToAccount(
        accountAddress: searchController.text,
        resetSearch: resetSearch,
      ));
    }

    listItems.add(SliverList(
      delegate: SliverChildListDelegate([
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 100),
              child: SvgPicture.asset(
                'assets/images/contacts.svg',
                width: 70.0,
                height: 70,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(I18n.of(context).sync_your_contacts),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Text(I18n.of(context).learn_more),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ContactsConfirmationScreen();
                        });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          I18n.of(context).activate,
                          style: TextStyle(color: Color(0xFF0377FF)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset('assets/images/blue_arrow.svg')
                      ],
                    ),
                    )
              ],
            )
          ],
        )
      ]),
    ));

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        converter: ContactsViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            automaticallyImplyLeading: false,
            title: I18n.of(context).send_to,
            sliverList: _buildPageList(viewModel),
          );
        });
  }
}
