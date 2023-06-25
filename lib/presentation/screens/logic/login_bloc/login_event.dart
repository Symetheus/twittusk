part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SignInEvent extends LoginEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });
}

class ResetPasswordEvent extends LoginEvent {
  final String email;

  ResetPasswordEvent({
    required this.email,
  });
}

class SignUpEvent extends LoginEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
