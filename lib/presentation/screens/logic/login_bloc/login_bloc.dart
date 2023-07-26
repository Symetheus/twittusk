import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:twittusk/domain/models/user_session.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/repository/notification_repository.dart';
import '../../../../domain/repository/tusk_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TuskRepository repository;
  final NotificationRepository notificationRepository;

  LoginBloc({
    required this.repository,
    required this.notificationRepository,
  }) : super(LoginState.initial()) {
    on<SignInEvent>(_onConnection);
    on<ResetPasswordEvent>(_onResetPassword);
    on<SignUpEvent>(_onSignUp);
    on<SignInGoogleEvent>(_onSignInGoogle);
    on<SignInTwitterEvent>(_onSignInTwitter);
  }

  void _onConnection(SignInEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final user = await repository.signIn(event.email, event.password);
      await notificationRepository.subscribeToTopic('users_${user.uid}');
      emit(state.copyWith(status: LoginStatus.success, user: user));
    } catch(e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.toString()));
    }
  }

  void _onResetPassword(ResetPasswordEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await repository.resetPassword(event.email);
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
        final user = await repository.signUp(event.username, event.email, event.password);
        emit(state.copyWith(status: LoginStatus.success, user: user));
      } catch(e) {
        emit(state.copyWith(status: LoginStatus.error, errorMessage: e.toString()));
      }
    }
  }

  void _onSignInGoogle(SignInGoogleEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final userSession = await repository.signInWithGoogle();
      final userExisted = await repository.getUserById(userSession.uid);
      if(userExisted == null) {
        final user = User(
            uid: userSession.uid,
            username: userSession.displayName ?? '',
            email: userSession.email ?? '',
            bio: '',
            arobase: userSession.email?.split('@')[0] ?? "",
            profilePicUri: 'https://firebasestorage.googleapis.com/v0/b/twittusk.appspot.com/o/profils%2Fprofile-default.png?alt=media&token=ae11ba74-e84d-4a95-ac0d-5e1b572dda95',
            bannerPicUri: 'https://firebasestorage.googleapis.com/v0/b/twittusk.appspot.com/o/banner%2Fbanner-default.jpg?alt=media&token=d88c5d06-3c62-4642-a392-48e6f534fc55',
        );
        await notificationRepository.subscribeToTopic('users_${userSession.uid}');
        await repository.addUser(user);
      }
      emit(state.copyWith(status: LoginStatus.success, user: userSession));
    } catch(e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.toString()));
    }
  }

  void _onSignInTwitter(SignInTwitterEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final userSession = await repository.signInWithTwitter();
      final userExisted = await repository.getUserById(userSession.uid);
      if(userExisted == null) {
        final user = User(
          uid: userSession.uid,
          username: userSession.displayName ?? '',
          email: userSession.email ?? '',
          bio: '',
          arobase: userSession.displayName ?? "",
          profilePicUri: 'https://firebasestorage.googleapis.com/v0/b/twittusk.appspot.com/o/profils%2Fprofile-default.png?alt=media&token=ae11ba74-e84d-4a95-ac0d-5e1b572dda95',
          bannerPicUri: 'https://firebasestorage.googleapis.com/v0/b/twittusk.appspot.com/o/banner%2Fbanner-default.jpg?alt=media&token=d88c5d06-3c62-4642-a392-48e6f534fc55',
        );
        await notificationRepository.subscribeToTopic('users_${userSession.uid}');
        await repository.addUser(user);
      }
      emit(state.copyWith(status: LoginStatus.success, user: userSession));
    } catch(e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.toString()));
    }
  }
}
