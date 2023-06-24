part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState {
  final LoginStatus status;
  final String errorMessage;
  final UserCredential? userCredential;

  LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage = '',
    this.userCredential,
  });

  factory LoginState.initial() {
    return LoginState(
      status: LoginStatus.initial,
      errorMessage: '',
      userCredential: null,
    );
  }

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    UserCredential? userCredential,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userCredential: userCredential ?? this.userCredential,
    );
  }
}
