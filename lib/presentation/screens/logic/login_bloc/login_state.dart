part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, successResetPassword, error }

class LoginState {
  final LoginStatus status;
  final String errorMessage;
  final UserSession? user;

  LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage = '',
    this.user,
  });

  factory LoginState.initial() {
    return LoginState(
      status: LoginStatus.initial,
      errorMessage: '',
      user: null,
    );
  }

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    UserSession? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
