part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginConnection extends LoginEvent {
  final String email;
  final String password;

  LoginConnection({
    required this.email,
    required this.password,
  });
}
