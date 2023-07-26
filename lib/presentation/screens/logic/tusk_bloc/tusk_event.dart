part of 'tusk_bloc.dart';

@immutable
abstract class TuskEvent {}

class InitUserEvent extends TuskEvent {}

class TuskCommentEvent extends TuskEvent {
  TuskCommentEvent({
    required this.tuskId,
  });

  final String tuskId;
}

class TuskAddCommentEvent extends TuskEvent {
  TuskAddCommentEvent({
    required this.tusk,
    required this.comment,
    required this.user,
  });

  final Tusk tusk;
  final String comment;
  final User user;
}

class TuskLikeEvent extends TuskEvent {
  TuskLikeEvent({
    required this.tuskId,
    required this.isLiked,
  });

  final String tuskId;
  final bool isLiked;
}

class TuskShareEvent extends TuskEvent {
  TuskShareEvent({
    required this.tuskId,
  });

  final String tuskId;
}