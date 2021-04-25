import 'package:auto_route/auto_route.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/screens/contacts/send_amount_arguments.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/preloader.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Map> fetchWalletByWalletAddress(
    String walletAddress) async {
  return {
    'walletAddress': walletAddress,
  };
}

void _openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Preloader(),
  );
}

void sendToContactByWalletAddress(BuildContext context, String displayName, String walletAddress,
    {ImageProvider avatar,
    String address,
    String countryCode,
    String isoCode}) async {
  if (address != null && address.isNotEmpty) {
    ExtendedNavigator.root.pushSendAmountScreen(
        pageArgs: SendAmountArguments(
            accountAddress: address, name: displayName, avatar: avatar));
    return;
  }
  try {
    _openLoadingDialog(context);
    Map res = await fetchWalletByWalletAddress(walletAddress);
    Navigator.of(context).pop();
    ExtendedNavigator.root.pushSendAmountScreen(
        pageArgs: SendAmountArguments(
            phoneNumber: res['phoneNumber'],
            accountAddress: res['walletAddress'],
            name: displayName,
            avatar: avatar));
  } catch (e) {
    Navigator.of(context).pop();
    throw '$e';
  }
}

void sendToPastedAddress(accountAddress) {
  ExtendedNavigator.root.pushSendAmountScreen(
      pageArgs: SendAmountArguments(
          accountAddress: accountAddress, name: formatAddress(accountAddress)));
}

void bracodeScannerHandler() async {
  try {
    PermissionStatus permission = await Permission.camera.request();
    if (permission == PermissionStatus.granted) {
      ScanResult scanResult = await BarcodeScanner.scan();
      if (isValidEthereumAddress(scanResult.rawContent)) {
        sendToPastedAddress(scanResult.rawContent);
      } else {
        List<String> parts = scanResult.rawContent.split(':');
        bool expression = parts.length == 2 && parts[0] == 'ethereum';
        if (expression) {
          final String accountAddress = parts[1];
          sendToPastedAddress(accountAddress);
        }
      }
    }
  } catch (e) {
    print('ERROR - BarcodeScanner');
  }
}
