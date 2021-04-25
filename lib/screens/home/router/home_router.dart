import 'package:auto_route/auto_route_annotations.dart';
import 'package:gostcoin_wallet_flutter/screens/backup/done_backup.dart';
import 'package:gostcoin_wallet_flutter/screens/backup/show_mnemonic.dart';
import 'package:gostcoin_wallet_flutter/screens/backup/verify_mnemonic.dart';
import 'package:gostcoin_wallet_flutter/screens/home/screens/home.dart';
import 'package:gostcoin_wallet_flutter/screens/home/screens/transaction_details.dart';
import 'package:gostcoin_wallet_flutter/screens/home/screens/token_screen.dart';
import 'package:gostcoin_wallet_flutter/screens/misc/about.dart';
import 'package:gostcoin_wallet_flutter/screens/misc/protect_your_wallet.dart';
import 'package:gostcoin_wallet_flutter/screens/misc/settings.dart';
import 'package:gostcoin_wallet_flutter/screens/misc/switch_commmunity.dart';
import 'package:gostcoin_wallet_flutter/screens/profile/screen/profile.dart';
import 'package:gostcoin_wallet_flutter/screens/trade/review_trade.dart';
import 'package:gostcoin_wallet_flutter/screens/trade/trade.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routesClassName: "HomeRoutes",
    routes: <AutoRoute>[
      MaterialRoute(
        initial: true,
        page: MainHomeScreen,
      ),
      MaterialRoute(page: TransactionDetailsScreen),
      MaterialRoute(page: TokenScreen),
      MaterialRoute(page: TradeScreen),
      MaterialRoute(page: ReviewTradeScreen),
      MaterialRoute(page: AboutScreen),
      MaterialRoute(page: ShowMnemonic),
      MaterialRoute(page: VerifyMnemonic),
      MaterialRoute(page: DoneBackup),
      MaterialRoute(page: SettingsScreen),
      MaterialRoute(page: SwitchCommunityScreen),
      MaterialRoute(page: ProtectYourWallet),
      MaterialRoute(page: ProfileScreen),
    ])
class $HomeRouter {}
