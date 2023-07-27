part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

class EditProfileGetCurrentUserEvent extends EditProfileEvent {}

class UserChangeAvatarEvent extends EditProfileEvent {
  final File image;

  UserChangeAvatarEvent(this.image);
}

class UserChangeBannerEvent extends EditProfileEvent {
  final File image;

  UserChangeBannerEvent(this.image);
}

class UpdateUserEvent extends EditProfileEvent {
  final User user;

  UpdateUserEvent(this.user);
}
