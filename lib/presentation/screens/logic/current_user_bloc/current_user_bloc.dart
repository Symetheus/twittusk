import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/user.dart';
import '../../../../domain/models/user_session.dart';
import '../../../../domain/repository/tusk_repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final TuskRepository _tuskRepository;

  CurrentUserBloc(this._tuskRepository) : super( CurrentUserState.initial() ) {
      on<GetCurrentUserEvent>(_onGetCurrentUser);
      on<CurrentUserLogoutEvent>(_onLogout);
  }

  void _onGetCurrentUser(GetCurrentUserEvent event, Emitter<CurrentUserState> emit) async {
    emit(state.copyWith(status: CurrentUserStatus.loading));
    try {
      final user = await _tuskRepository.getCurrentUser();
      emit(state.copyWith(status: CurrentUserStatus.success, user: user));
    } catch(e) {
      emit(state.copyWith(status: CurrentUserStatus.error, errorMessage: e.toString()));
    }
  }

  void _onLogout(CurrentUserLogoutEvent event, Emitter<CurrentUserState> emit) async {
    emit(state.copyWith(status: CurrentUserStatus.logoutLoading));
    try {
      await _tuskRepository.logout();
      emit(state.copyWith(status: CurrentUserStatus.logoutSuccess));
    } catch(e) {
      emit(state.copyWith(status: CurrentUserStatus.logoutError, errorMessage: e.toString()));
    }
  }
}
