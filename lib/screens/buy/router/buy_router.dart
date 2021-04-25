import 'package:auto_route/auto_route_annotations.dart';
import 'package:gostcoin_wallet_flutter/screens/buy/business.dart';
import 'package:gostcoin_wallet_flutter/screens/buy/buy.dart';
import 'package:gostcoin_wallet_flutter/screens/buy/map.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routesClassName: "BusinessesRoutes",
    routes: <AutoRoute>[
      MaterialRoute(initial: true, page: BuyScreen),
      MaterialRoute(page: BusinessPage),
      MaterialRoute(page: MapScreen),
    ])
class $BuyRouter {}
