part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, actionLoading, success, actionSuccess, error }

class FeedState {
  final List<Tusk> tusks;
  final String errorMessage;
  final FeedStatus status;

  FeedState({
    required this.tusks,
    required this.errorMessage,
    required this.status,
  });

  factory FeedState.initial() {
    return FeedState(
      tusks: [],
      errorMessage: '',
      status: FeedStatus.initial,
    );
  }

  FeedState copyWith({
    List<Tusk>? tusks,
    String? errorMessage,
    FeedStatus? status,
  }) {
    return FeedState(
      tusks: tusks ?? this.tusks,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
