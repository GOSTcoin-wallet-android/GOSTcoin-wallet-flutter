import 'package:country_code_picker/country_code.dart';
import 'package:equatable/equatable.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class OnboardViewModel extends Equatable {
  final String countryCode;
  final String accountAddress;
  final String verificationId;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final bool isLoginRequest;
  final bool isVerifyRequest;
  final Function(CountryCode) signUp;
  final Function(String, String) verify;
  final Function(String) setPincode;
  final Function(String) setDisplayName;
  final Function(BiometricAuth) setSecurityType;
  final dynamic verifyException;
  final dynamic signupException;
  final Function resetErrors;

  OnboardViewModel(
      {this.setSecurityType,
      this.countryCode,
      this.accountAddress,
      this.verificationId,
      this.loginRequestSuccess,
      this.loginVerifySuccess,
      this.signUp,
      this.verify,
      this.setPincode,
      this.setDisplayName,
      this.isLoginRequest,
      this.isVerifyRequest,
      this.verifyException,
      this.signupException,
      this.resetErrors});

  static OnboardViewModel fromStore(Store<AppState> store) {
    //ExtendedNavigator.root.pushUserNameScreen();
    return OnboardViewModel(
        countryCode: store.state.userState.countryCode,
        accountAddress: store.state.userState.accountAddress,
        loginRequestSuccess: store.state.userState.loginRequestSuccess,
        loginVerifySuccess: store.state.userState.loginVerifySuccess,
        verificationId: store.state.userState.verificationId,
        isVerifyRequest: store.state.userState.isVerifyRequest,
        isLoginRequest: store.state.userState.isLoginRequest,
        signupException: store.state.userState.signupException,
        verifyException: store.state.userState.verifyException,
        signUp: (CountryCode countryCode) {
          store.dispatch(LoginRequest(
              countryCode: countryCode
          ));
        },
        verify: (verificationCode, verificationId) {
          store.dispatch(VerifyRequest(
            verificationCode: verificationCode,
            verificationId: verificationId,
          ));
        },
        setPincode: (pincode) {
          store.dispatch(SetPincodeSuccess(pincode));
        },
        setDisplayName: (displayName) {
          store.dispatch(setDisplayNameCall(displayName));
        },
        setSecurityType: (biometricAuth) {
          store.dispatch(SetSecurityType(biometricAuth: biometricAuth));
        },
        resetErrors: () {
          store.dispatch(SetIsVerifyRequest(message: ''));
          store.dispatch(SetIsLoginRequest(message: ''));
        });
  }

  @override
  List<Object> get props => [
        countryCode,
        accountAddress,
        loginRequestSuccess,
        loginVerifySuccess,
        verificationId,
        isVerifyRequest,
        isLoginRequest,
        verifyException,
        signupException
      ];
}
