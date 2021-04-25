import 'package:auto_route/auto_route.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/services.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  final loginRequest = _createLoginRequestMiddleware();
  final verifyRequest = _createVerifyPhoneNumberMiddleware();

  return [
    TypedMiddleware<AppState, LoginRequest>(loginRequest),
    TypedMiddleware<AppState, VerifyRequest>(verifyRequest),
  ];
}

Middleware<AppState> _createLoginRequestMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final logger = await AppFactory().getLogger('action');
    if (action is LoginRequest) {
      try {
        store.dispatch(SetIsLoginRequest(isLoading: true));
        store.dispatch(new LoginRequestSuccess(
          countryCode: action.countryCode,
        ));
      }
      catch (e, s) {
        store.dispatch(SetIsLoginRequest(isLoading: false));
        logger.severe('ERROR - LoginRequest $e');
        await AppFactory().reportError(e, stackTrace: s);
        store.dispatch(new ErrorAction(e.toString()));
        store.dispatch(segmentTrackCall("ERROR in LoginRequest", properties: new Map.from({ "error": e.toString() })));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createVerifyPhoneNumberMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    //final logger = await AppFactory().getLogger('action');
    if (action is VerifyRequest) {
      store.dispatch(SetIsVerifyRequest(isLoading: true));
      store.dispatch(setDeviceId(false));
      final String accountAddress = store.state.userState.accountAddress;
      final String identifier = store.state.userState.identifier;
      store.dispatch(LoginVerifySuccess());
      store.dispatch(SetIsVerifyRequest(isLoading: false));
      store.dispatch(segmentTrackCall("Wallet: verified phone number"));
      ExtendedNavigator.root.pushUserNameScreen();
    }
    next(action);
  };
}