import 'package:auto_route/auto_route_annotations.dart';
import 'package:gostcoin_wallet_flutter/screens/home/home_page.dart';
import 'package:gostcoin_wallet_flutter/screens/misc/webview_page.dart';
import 'package:gostcoin_wallet_flutter/screens/route_guards.dart';
import 'package:gostcoin_wallet_flutter/screens/misc/lock_screen.dart';
import 'package:gostcoin_wallet_flutter/screens/misc/pincode_colored.dart';
import 'package:gostcoin_wallet_flutter/screens/misc/security.dart';
import 'package:gostcoin_wallet_flutter/screens/signup/recovery.dart';
import 'package:gostcoin_wallet_flutter/screens/signup/username.dart';
import 'package:gostcoin_wallet_flutter/screens/signup/choose_language.dart';
import 'package:gostcoin_wallet_flutter/screens/signup/verify.dart';
import 'package:gostcoin_wallet_flutter/screens/splash/splash.dart';
import 'package:gostcoin_wallet_flutter/screens/send_flow/send_amount.dart';
import 'package:gostcoin_wallet_flutter/screens/send_flow/send_review.dart';
import 'package:gostcoin_wallet_flutter/screens/send_flow/send_success.dart';
import 'package:gostcoin_wallet_flutter/screens/unknown_route.dart';

@MaterialAutoRouter(generateNavigationHelperExtension: true, routes: [
  MaterialRoute(page: LockScreen, name: 'lockScreen', initial: true),
  MaterialRoute(page: SecurityScreen, name: 'securityScreen'),
  MaterialRoute(page: ColorsPincodeScreen, name: 'pincode'),
  MaterialRoute(page: RecoveryPage),
  MaterialRoute(page: SplashScreen),
  MaterialRoute(page: ChooseLanguageScreen),
  MaterialRoute(page: VerifyScreen),
  MaterialRoute(page: UserNameScreen),
  MaterialRoute(page: WebViewPage, name: 'webview', fullscreenDialog: true),
  MaterialRoute(guards: [AuthGuard], page: HomePage),
  MaterialRoute(guards: [AuthGuard], page: SendAmountScreen),
  MaterialRoute(guards: [AuthGuard], page: SendReviewScreen),
  MaterialRoute(guards: [AuthGuard], page: SendSuccessScreen),
  AdaptiveRoute(path: '*', page: UnknownRouteScreen)
])
class $Router {}
