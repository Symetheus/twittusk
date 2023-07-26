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
}
