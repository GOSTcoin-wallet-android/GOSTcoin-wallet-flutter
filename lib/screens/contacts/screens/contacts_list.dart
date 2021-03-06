
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:gostcoin_wallet_flutter/models/app_state.dart';
import 'package:gostcoin_wallet_flutter/models/views/contacts.dart';
import 'package:gostcoin_wallet_flutter/screens/contacts/screens/send_to_account.dart';
// import 'package:gostcoin_wallet_flutter/screens/contacts/widgets/recent_contacts.dart';
import 'package:gostcoin_wallet_flutter/screens/contacts/widgets/search_panel.dart';
import "package:ethereum_address/ethereum_address.dart";
import 'package:gostcoin_wallet_flutter/widgets/preloader.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  bool hasSynced = false;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        onInitialBuild: (viewModel) {
          Segment.screen(screenName: '/contacts-screen');
        },
        converter: ContactsViewModel.fromStore,
        builder: (_, viewModel) {
          return Center(
                  child: Preloader(),
                );
        });
  }

  Future<void> refreshContacts() async {
    searchController.addListener(filterList);
    filterList();
  }

  @override
  void initState() {
    super.initState();
    refreshContacts();
  }

  filterList() {
  }

  void resetSearch() {
    FocusScope.of(context).unfocus();
    if (mounted) {
      setState(() {
        searchController.text = '';
      });
    }
  }

  SliverList listBody(ContactsViewModel viewModel) {
    List<Widget> listItems = List();
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }

  List<Widget> _buildPageList(ContactsViewModel viewModel) {
    List<Widget> listItems = List();

    listItems.add(SearchPanel(
      searchController: searchController,
    ));

    // if (searchController.text.isEmpty) {
    // listItems.add(RecentContacts());
    // } else
    if (isValidEthereumAddress(searchController.text)) {
      listItems.add(SendToAccount(
        accountAddress: searchController.text,
        resetSearch: resetSearch,
      ));
    }

    return listItems;
  }
}
