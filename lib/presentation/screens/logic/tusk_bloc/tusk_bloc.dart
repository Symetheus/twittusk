import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';

part 'tusk_event.dart';

part 'tusk_state.dart';

class TuskBloc extends Bloc<TuskEvent, TuskState> {
  final TuskRepository _tuskRepository;

  TuskBloc(this._tuskRepository) : super(TuskState.initial()) {
    on<InitUserEvent>(_onInitTusk);
    on<TuskAddCommentEvent>(_onAddCommentTusk);
    on<TuskCommentEvent>(_onCommentTusk);
    on<TuskLikeEvent>(_likeTusk);
    on<TuskShareEvent>(_shareTusk);
  }

  void _onInitTusk(TuskEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.loading));
    try {
      final user = await _tuskRepository.getCurrentUser();
      print(user);
      emit(state.copyWith(user: user, status: TuskStatus.initUser));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }

  void _onAddCommentTusk(TuskAddCommentEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.actionLoading));

    if (event.comment.isEmpty) {
      emit(state.copyWith(errorMessage: 'Le commentaire ne peut pas être vide !', status: TuskStatus.errorComment));
      emit(state.copyWith(errorMessage: 'Le commentaire ne peut pas être vide !', status: TuskStatus.success));
      return;
    }

    try {
      await _tuskRepository.addCommentToTusk(event.tusk.id, event.comment, event.user);
      emit(state.copyWith(status: TuskStatus.actionSuccess));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }

  void _onCommentTusk(TuskCommentEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.loading));
    try {
      final tusksStream = _tuskRepository.getCommentsForTusk(event.tuskId);

      await emit.forEach(tusksStream, onData: (tusks) {
        return state.copyWith(tusks: tusks, status: TuskStatus.success);
      }).catchError((error) {
        emit(state.copyWith(
          errorMessage: error.toString(),
          status: TuskStatus.error,
        ));
      });

    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }

  void _likeTusk(TuskLikeEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.actionLoading));
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
      emit(state.copyWith(status: TuskStatus.actionSuccess));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }

  void _shareTusk(TuskShareEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.actionLoading));
    try {
      final link = await _tuskRepository.generateTuskDynamicLink(event.tuskId);
      emit(state.copyWith(status: TuskStatus.actionSuccess, dynamicLink: link));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }
}
