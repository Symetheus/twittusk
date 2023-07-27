import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/repository/tusk_repository.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final TuskRepository tuskRepository;

  EditProfileBloc(this.tuskRepository) : super(EditProfileState.initial()) {
    on<EditProfileGetCurrentUserEvent>(_onGetCurrentUser);
    on<UserChangeAvatarEvent>(_onChangeAvatar);
    on<UserChangeBannerEvent>(_onChangeBanner);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  void _onGetCurrentUser(EditProfileGetCurrentUserEvent event,
      Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: EditProfileStatus.loading));
    try {
      final user = await tuskRepository.getCurrentUser();
      final avatarUri = user!.profilePicUri;
      final bannerUri = user.bannerPicUri;
      emit(state.copyWith(
        status: EditProfileStatus.success,
        user: user,
        avatarUri: avatarUri,
        bannerUri: bannerUri,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: EditProfileStatus.error, errorMessage: e.toString()));
    }
  }

  void _onChangeAvatar(
      UserChangeAvatarEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: EditProfileStatus.loadingImage));
    try {
      var imageUri = await tuskRepository.uploadImage(event.image.path);
      emit(state.copyWith(
          status: EditProfileStatus.successImage, avatarUri: imageUri));
    } catch (e) {
      emit(state.copyWith(
          status: EditProfileStatus.error, errorMessage: e.toString()));
    }
  }

  void _onChangeBanner(
      UserChangeBannerEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: EditProfileStatus.loadingImage));
    try {
      var imageUri = await tuskRepository.uploadImage(event.image.path);
      emit(state.copyWith(
          status: EditProfileStatus.successImage, bannerUri: imageUri));
    } catch (e) {
      emit(state.copyWith(
          status: EditProfileStatus.error, errorMessage: e.toString()));
    }
  }

  void _onUpdateUser(
      UpdateUserEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: EditProfileStatus.loading));
    try {
      await tuskRepository.updateUser(event.user);
      emit(state.copyWith(status: EditProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: EditProfileStatus.error, errorMessage: e.toString()));
    }
  }
}
