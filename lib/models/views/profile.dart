import 'package:equatable/equatable.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';

class ProfileViewModel extends Equatable {
  final String walletAddress;
  final String avatarUrl;
  final String displayName;
  final void Function(String displayName) updateDisplaName;
  final void Function(ImageSource source) editAvatar;

  ProfileViewModel(
      {this.walletAddress,
      this.displayName,
      this.editAvatar,
      this.avatarUrl,
      this.updateDisplaName});

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
        displayName: store.state.userState.displayName ?? '',
        avatarUrl: store.state.userState.avatarUrl,
        walletAddress: formatAddress(store.state.userState.walletAddress),
        editAvatar: (source) {
          store.dispatch(updateUserAvatarCall(source));
        },
        updateDisplaName: (displayName) {
          store.dispatch(updateDisplayNameCall(displayName));
        });
  }

  @override
  List get props => [walletAddress, displayName];
}
