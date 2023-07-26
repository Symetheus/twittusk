import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/repository/notification_repository.dart';
import '../../../../domain/repository/tusk_repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final TuskRepository tuskRepository;
  final NotificationRepository notificationRepository;

  CurrentUserBloc({
    required this.tuskRepository,
    required this.notificationRepository,
  }) : super( CurrentUserState.initial() ) {
      on<GetCurrentUserEvent>(_onGetCurrentUser);
      on<CurrentUserLogoutEvent>(_onLogout);
  }

  void _onGetCurrentUser(GetCurrentUserEvent event, Emitter<CurrentUserState> emit) async {
    emit(state.copyWith(status: CurrentUserStatus.loading));
    try {
      final user = await tuskRepository.getCurrentUser();
      emit(state.copyWith(status: CurrentUserStatus.success, user: user));
    } catch(e) {
      emit(state.copyWith(status: CurrentUserStatus.error, errorMessage: e.toString()));
    }
  }

  void _onLogout(CurrentUserLogoutEvent event, Emitter<CurrentUserState> emit) async {
    emit(state.copyWith(status: CurrentUserStatus.logoutLoading));
    try {
      final user = await tuskRepository.getCurrentUser();
      if(user != null) {
        await notificationRepository.unsubscribeFromTopic('users_${user.uid}');
      }
      await tuskRepository.logout();
      emit(state.copyWith(status: CurrentUserStatus.logoutSuccess));
    } catch(e) {
      emit(state.copyWith(status: CurrentUserStatus.logoutError, errorMessage: e.toString()));
    }
  }
}
