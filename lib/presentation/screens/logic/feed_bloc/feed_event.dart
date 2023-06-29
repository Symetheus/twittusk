part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class FeedFetchEvent extends FeedEvent {}

class FeedLikeEvent extends FeedEvent {
  final String tuskId;
  final bool isLiked;

  FeedLikeEvent({
    required this.tuskId,
    required this.isLiked,
  });
}

class FeedShareEvent extends FeedEvent {
  final String tuskId;

  FeedShareEvent({
    required this.tuskId,
  });
}
