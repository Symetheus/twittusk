part of 'tusk_bloc.dart';

enum TuskStatus { initial, initUser, loading, actionLoading, success, actionSuccess, dynamicLinkSuccess, error, errorComment }

class TuskState {
  final TuskStatus status;
  final String errorMessage;
  final List<Tusk> tusks;
  final Uri? dynamicLink;
  final User? user;

  TuskState({
    required this.errorMessage,
    required this.status,
    required this.tusks,
    this.dynamicLink,
    this.user
  });

  factory TuskState.initial() {
    return TuskState(
      tusks: [],
      errorMessage: '',
      status: TuskStatus.initial,
    );
  }

  TuskState copyWith({
    TuskStatus? status,
    String? errorMessage,
    List<Tusk>? tusks,
    Uri? dynamicLink,
    User? user,
  }) {
    return TuskState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      tusks: tusks ?? this.tusks,
      dynamicLink: dynamicLink ?? this.dynamicLink,
      user: user ?? this.user,
    );
  }
}
