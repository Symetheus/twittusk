import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../../../domain/repository/tusk_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TuskRepository _repository;

  LoginBloc(this._repository) : super(LoginState.initial()) {
    on<LoginConnection>(_onConnection);
  }

  void _onConnection(LoginConnection event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final credentials = await _repository.signIn(event.email, event.password);
      emit(state.copyWith(status: LoginStatus.success, userCredential: credentials));
    } catch(e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.toString()));
    }
  }
}
