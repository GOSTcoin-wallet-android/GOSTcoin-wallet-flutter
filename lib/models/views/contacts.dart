import 'package:equatable/equatable.dart';
import 'package:gostcoin_wallet_flutter/models/app_state.dart';
import 'package:gostcoin_wallet_flutter/models/community/business.dart';
import 'package:gostcoin_wallet_flutter/models/community/community.dart';
import 'package:gostcoin_wallet_flutter/models/tokens/token.dart';
import 'package:gostcoin_wallet_flutter/models/transactions/transactions.dart';
import 'package:gostcoin_wallet_flutter/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';

class ContactsViewModel extends Equatable {
  final Transactions transactions;
  final Map<String, String> reverseContacts;
  final String countryCode;
  final String isoCode;
  final List<Business> businesses;
  final Function(String eventName) trackCall;
  final Function(Map<String, dynamic> traits) idenyifyCall;
  final Community community;

  ContactsViewModel(
      {
      this.transactions,
      this.reverseContacts,
      this.countryCode,
      this.community,
      this.isoCode,
      this.businesses,
      this.trackCall,
      this.idenyifyCall});

  static ContactsViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres];
    Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];
    return ContactsViewModel(
        isoCode: store.state.userState.isoCode,
        businesses: community?.businesses ?? [],
        community: community,
        transactions: token?.transactions,
        reverseContacts: store.state.userState.reverseContacts,
        countryCode: store.state.userState.countryCode,
        trackCall: (String eventName) {
          store.dispatch(segmentTrackCall(eventName));
        },
        idenyifyCall: (Map<String, dynamic> traits) {
          store.dispatch(segmentIdentifyCall(traits));
        });
  }

  @override
  List<Object> get props => [
        transactions,
        reverseContacts,
        countryCode,
        businesses,
        isoCode,
        community
      ];
}
