import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';

part 'profile_feed_event.dart';

part 'profile_feed_state.dart';

class ProfileFeedBloc extends Bloc<ProfileFeedEvent, ProfileFeedState> {
  final TuskRepository _tuskRepository;

  ProfileFeedBloc(this._tuskRepository) : super(ProfileFeedState.initial()) {
    on<UserFeedFetchEvent>(_fetchTusksByUser);
    on<FeedLikeEvent>(_likeTusk);
    on<FeedShareEvent>(_shareTusk);
  }

  void _likeTusk(FeedLikeEvent event, Emitter<ProfileFeedState> emit) async {
    emit(state.copyWith(status: ProfileFeedStatus.loading));
    try {
      final likes = await _tuskRepository.getMyLikesByTusk(event.tuskId);

      if (likes.isEmpty) {
        await _tuskRepository.addLike(event.tuskId, event.isLiked);
      } else {
        for (var like in likes) {
          await _tuskRepository.removeLike(like.id, event.tuskId);
        }
        await _tuskRepository.addLike(event.tuskId, event.isLiked);
      }
      emit(state.copyWith(status: ProfileFeedStatus.actionSuccess));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: ProfileFeedStatus.error,
      ));
    }
  }

  void _shareTusk(FeedShareEvent event, Emitter<ProfileFeedState> emit) async {
    emit(state.copyWith(status: ProfileFeedStatus.loading));
    try {
      final link = await _tuskRepository.generateTuskDynamicLink(event.tuskId);
      emit(state.copyWith(status: ProfileFeedStatus.dynamicLinkSuccess, dynamicLink: link));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: ProfileFeedStatus.error,
      ));
    }
  }

  void _fetchTusksByUser(UserFeedFetchEvent event, Emitter<ProfileFeedState> emit) async {
    emit(state.copyWith(status: ProfileFeedStatus.loading));
    try {
      await emit.forEach(_tuskRepository.getTusksByUser(event.user), onData: (tusks) {
        print(tusks);
        return state.copyWith(tusks: tusks, status: ProfileFeedStatus.success);
      }).catchError((error) {
        emit(state.copyWith(errorMessage: error.toString(), status: ProfileFeedStatus.error));
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: ProfileFeedStatus.error));
    }
  }
}
