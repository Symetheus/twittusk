part of 'edit_profile_bloc.dart';

enum EditProfileStatus {
  initial,
  loading,
  success,
  successImage,
  loadingImage,
  error,
}

class EditProfileState {
  final User? user;
  final String errorMessage;
  final String? avatarUri;
  final String? bannerUri;
  final EditProfileStatus status;

  EditProfileState({
    required this.user,
    required this.errorMessage,
    required this.status,
    this.avatarUri,
    this.bannerUri,
  });

  factory EditProfileState.initial() {
    return EditProfileState(
      user: null,
      errorMessage: '',
      status: EditProfileStatus.initial,
    );
  }

  EditProfileState copyWith({
    User? user,
    String? errorMessage,
    EditProfileStatus? status,
    String? avatarUri,
    String? bannerUri,
  }) {
    return EditProfileState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      avatarUri: avatarUri ?? this.avatarUri,
      bannerUri: bannerUri ?? this.bannerUri,
    );
  }
}
