import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/repository/tusk_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TuskRepository _repository;

  LoginBloc(this._repository) : super(LoginState.initial()) {
    on<SignInEvent>(_onConnection);
    on<ResetPasswordEvent>(_onResetPassword);
    on<SignUpEvent>(_onSignUp);
  }

  void _onConnection(SignInEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final user = await _repository.signIn(event.email, event.password);
      emit(state.copyWith(status: LoginStatus.success, user: user));
    } catch(e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.toString()));
    }
  }

  void _onResetPassword(ResetPasswordEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _repository.resetPassword(event.email);
      emit(state.copyWith(status: LoginStatus.successResetPassword));
    } catch(e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.toString()));
    }
  }

  void _onSignUp(SignUpEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    if(event.password != event.confirmPassword) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: 'Passwords do not match'));
    } else {
      try {
        final user = await _repository.signUp(event.email, event.password);
        emit(state.copyWith(status: LoginStatus.success, user: user));
      } catch(e) {
        emit(state.copyWith(status: LoginStatus.error, errorMessage: e.toString()));
      }
    }

  }
}
