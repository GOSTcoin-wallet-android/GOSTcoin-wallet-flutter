import 'package:gostcoin_wallet_flutter/models/community/business.dart';
import 'package:gostcoin_wallet_flutter/models/community/community.dart';
import 'package:gostcoin_wallet_flutter/models/plugins/wallet_banner.dart';
import 'package:gostcoin_wallet_flutter/models/tokens/token.dart';
import 'package:gostcoin_wallet_flutter/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:gostcoin_wallet_flutter/models/app_state.dart';
import 'package:equatable/equatable.dart';

class BuyViewModel extends Equatable {
  final List<Business> businesses;
  final Function() loadBusinesses;
  final bool isCommunityBusinessesFetched;
  final Token token;
  final String communityAddress;
  final WalletBannerPlugin walletBanner;

  @override
  List<Object> get props => [
        token,
        businesses,
        isCommunityBusinessesFetched,
        businesses,
        walletBanner
      ];

  BuyViewModel(
      {this.communityAddress,
      this.businesses,
      this.loadBusinesses,
      this.token,
      this.isCommunityBusinessesFetched,
      this.walletBanner});

  static BuyViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            Community.initial();
    Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];
    return BuyViewModel(
        communityAddress: communityAddress,
        token: token,
        businesses: community?.businesses ?? [],
        walletBanner: community.plugins.walletBanner,
        isCommunityBusinessesFetched:
            store.state.cashWalletState.isCommunityBusinessesFetched,
        loadBusinesses: () {
          store.dispatch(getBusinessListCall());
        });
  }
}
