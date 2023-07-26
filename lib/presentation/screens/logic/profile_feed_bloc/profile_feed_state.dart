part of 'profile_feed_bloc.dart';

enum ProfileFeedStatus { initial, loading, success, dynamicLinkSuccess, actionSuccess, error }

class ProfileFeedState {
  final List<Tusk> tusks;
  final String errorMessage;
  final ProfileFeedStatus status;
  final Uri? dynamicLink;

  ProfileFeedState({
    required this.tusks,
    required this.errorMessage,
    required this.status,
    this.dynamicLink,
  });

  factory ProfileFeedState.initial() {
    return ProfileFeedState(
      tusks: [],
      errorMessage: '',
      status: ProfileFeedStatus.initial,
    );
  }

  ProfileFeedState copyWith({
    List<Tusk>? tusks,
    String? errorMessage,
    ProfileFeedStatus? status,
    Uri? dynamicLink,
  }) {
    return ProfileFeedState(
      tusks: tusks ?? this.tusks,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      dynamicLink: dynamicLink ?? this.dynamicLink,
    );
  }
}
