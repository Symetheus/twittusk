import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../domain/models/tusk.dart';
import '../../../../domain/repository/feed_repository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final TuskRepository _tuskRepository;

  FeedBloc(this._tuskRepository) : super(FeedState.initial()) {
    on<FeedFetchEvent>(_fetchTusks);
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
}
