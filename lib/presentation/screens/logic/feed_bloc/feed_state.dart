part of 'feed_bloc.dart';

enum FeedStatus {
  initial,
  loading,
  actionLoading,
  success,
  actionSuccess,
  dynamicLinkSuccess,
  error
}

class FeedState {
  final List<Tusk> tusks;
  final String errorMessage;
  final FeedStatus status;
  final Uri? dynamicLink;

  FeedState({
    required this.tusks,
    required this.errorMessage,
    required this.status,
    this.dynamicLink,
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
    Uri? dynamicLink,
  }) {
    return FeedState(
      tusks: tusks ?? this.tusks,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      dynamicLink: dynamicLink ?? this.dynamicLink,
    );
  }
}
