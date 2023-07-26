part of 'current_user_bloc.dart';

enum CurrentUserStatus {
  initial,
  loading,
  success,
  logoutSuccess,
  logoutLoading,
  logoutError,
  error
}
class CurrentUserState {
  final User? user;
  final String errorMessage;
  final CurrentUserStatus status;

  CurrentUserState({
    required this.user,
    required this.errorMessage,
    required this.status,
  });

  factory CurrentUserState.initial() {
    return CurrentUserState(
      user: null,
      errorMessage: '',
      status: CurrentUserStatus.initial,
    );
  }

  CurrentUserState copyWith({
    User? user,
    String? errorMessage,
    CurrentUserStatus? status,
  }) {
    return CurrentUserState(
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
