import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/views/onboard.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/screens/routes.gr.dart';

class ChooseLanguageScreen extends StatefulWidget {
  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  final _formKey = GlobalKey<FormState>();
  CountryCode countryCode = CountryCode(dialCode: '‎+1', code: 'US');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_updateCountryCode);
    super.initState();
  }

  _updateCountryCode(_) {
    Locale myLocale = Localizations.localeOf(context);
    if (myLocale.countryCode != null) {
      Map localeData = codes.firstWhere(
          (Map code) => code['code'] == myLocale.countryCode,
          orElse: () => null);
      if (mounted && localeData != null) {
        setState(() {
          countryCode = CountryCode(
              dialCode: localeData['dial_code'], code: localeData['code']);
        });
      }
    }
  }

  void onPressed(Function(CountryCode) signUp) {
    signUp(countryCode);
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/signup-screen');
    return MainScaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        withPadding: true,
        title: I18n.of(context).sign_up,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
                  child: Text(I18n.of(context).choose_language,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ],
            ),
          ),
        ],
        footer: Padding(
          padding: EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 280,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              width: 2.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: CountryCodePicker(
                            onChanged: (_countryCode) {
                              setState(() {
                                countryCode = _countryCode;
                              });
                              Segment.track(
                                  eventName: 'Wallet: country code selected',
                                  properties: Map.from({
                                    'Dial code': _countryCode.dialCode,
                                    'County code': _countryCode.code,
                                  }));
                            },
                            searchStyle: TextStyle(fontSize: 18),
                            showFlag: true,
                            initialSelection: countryCode.code,
                            showCountryOnly: false,
                            textStyle: TextStyle(fontSize: 18),
                            alignLeft: false,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                StoreConnector<AppState, OnboardViewModel>(
                    distinct: true,
                    converter: OnboardViewModel.fromStore,
                    builder: (_, viewModel) => Center(
                          child: PrimaryButton(
                            label: I18n.of(context).next_button,
                            fontSize: 16,
                            labelFontWeight: FontWeight.normal,
                            onPressed: () {
                              onPressed(viewModel.signUp);
                              ExtendedNavigator.root.pushSecurityScreen();
                            },
                            preload: viewModel.isLoginRequest,
                          ),
                        ))
              ],
            ),
          ),
        ));
  }
}
