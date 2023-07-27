part of 'current_user_bloc.dart';

@immutable
abstract class CurrentUserEvent {}

class GetCurrentUserEvent extends CurrentUserEvent {}

class CurrentUserLogoutEvent extends CurrentUserEvent {}

class CurrentUserAddTuskEvent extends CurrentUserEvent {
  final User user;
  final DateTime publishedAt;
  final String description;
  final String? image;

  CurrentUserAddTuskEvent(
    this.user,
    this.publishedAt,
    this.description,
    this.image,
  );
}
