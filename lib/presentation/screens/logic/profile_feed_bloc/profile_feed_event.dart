part of 'profile_feed_bloc.dart';

@immutable
abstract class ProfileFeedEvent {}

class UserFeedFetchEvent extends ProfileFeedEvent {
  UserFeedFetchEvent(this.user);

  final User user;
}

class FeedLikeEvent extends ProfileFeedEvent {
  final String tuskId;
  final bool isLiked;

  FeedLikeEvent({
    required this.tuskId,
    required this.isLiked,
  });
}

class FeedShareEvent extends ProfileFeedEvent {
  final String tuskId;

  FeedShareEvent({
    required this.tuskId,
  });
}
