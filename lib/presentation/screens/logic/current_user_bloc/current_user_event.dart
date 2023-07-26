part of 'current_user_bloc.dart';

@immutable
abstract class CurrentUserEvent {}

class GetCurrentUserEvent extends CurrentUserEvent {}
