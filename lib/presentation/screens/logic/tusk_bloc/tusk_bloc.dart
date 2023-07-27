import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';
import '../../../../domain/repository/notification_repository.dart';

part 'tusk_event.dart';

part 'tusk_state.dart';

class TuskBloc extends Bloc<TuskEvent, TuskState> {
  final TuskRepository tuskRepository;
  final NotificationRepository notificationRepository;

  TuskBloc({
    required this.tuskRepository,
    required this.notificationRepository
  }) : super(TuskState.initial()) {
    on<InitUserEvent>(_onInitTusk);
    on<TuskAddCommentEvent>(_onAddCommentTusk);
    on<TuskCommentEvent>(_onCommentTusk);
    on<TuskLikeEvent>(_likeTusk);
    on<TuskShareEvent>(_shareTusk);
  }

  void _onInitTusk(InitUserEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.loading));
    try {
      final user = await tuskRepository.getCurrentUser();
      final tusk = await tuskRepository.getTuskById(event.tuskId);
      emit(state.copyWith(user: user, mainTusk: tusk, status: TuskStatus.initUser));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }

  void _onAddCommentTusk(TuskAddCommentEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.actionLoading));
    try {
      await tuskRepository.addCommentToTusk(event.tusk.id, event.comment, event.user);
      await notificationRepository.sendMessageFromTuskId(
        event.tusk.id,
        'Someone comment your tusk',
        event.comment,
      );
      emit(state.copyWith(status: TuskStatus.actionSuccess));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }

  void _onCommentTusk(TuskCommentEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.loading));
    try {
      final tusksStream = await tuskRepository.getCommentsForTusk(event.tuskId);

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
      final likes = await tuskRepository.getMyLikesByTusk(event.tuskId);

      if (likes.isEmpty) {
        await tuskRepository.addLike(event.tuskId, event.isLiked);
      } else {
        for (var like in likes) {
          await tuskRepository.removeLike(like.id, event.tuskId);
        }
        await tuskRepository.addLike(event.tuskId, event.isLiked);
      }
      emit(state.copyWith(status: TuskStatus.actionSuccess));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }

  void _shareTusk(TuskShareEvent event, Emitter<TuskState> emit) async {
    emit(state.copyWith(status: TuskStatus.actionLoading));
    try {
      final link = await tuskRepository.generateTuskDynamicLink(event.tuskId);
      emit(state.copyWith(status: TuskStatus.actionSuccess, dynamicLink: link));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: TuskStatus.error));
    }
  }
}
