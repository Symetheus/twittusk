import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';

part 'feed_event.dart';

part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final TuskRepository _tuskRepository;

  FeedBloc(this._tuskRepository) : super(FeedState.initial()) {
    on<FeedFetchEvent>(_fetchTusks);
    on<FeedLikeEvent>(_likeTusk);
  }

  void _fetchTusks(FeedFetchEvent event, Emitter<FeedState> emit) async {
    emit(state.copyWith(status: FeedStatus.loading));
    try {
      await emit.forEach(_tuskRepository.getTusks(), onData: (tusks) {
        return state.copyWith(tusks: tusks, status: FeedStatus.success);
      }).catchError((error) {
        emit(state.copyWith(
          errorMessage: error.toString(),
          status: FeedStatus.error,
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: FeedStatus.error,
      ));
    }
  }

  void _likeTusk(FeedLikeEvent event, Emitter<FeedState> emit) async {
    emit(state.copyWith(status: FeedStatus.actionLoading));
    try {
      final likes = await _tuskRepository.getMyLikesByTusk(event.tuskId);

      if (likes.isEmpty) {
        await _tuskRepository.addLike(event.tuskId, event.isLiked);
      } else {
        for(var like in likes) {
          await _tuskRepository.removeLike(like.id, event.tuskId);
        }
        await _tuskRepository.addLike(event.tuskId, event.isLiked);
      }
      emit(state.copyWith(status: FeedStatus.actionSuccess));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: FeedStatus.error,
      ));
    }
  }
}
