import 'package:twittusk/domain/models/user.dart';

class Like {
  final String id;
  final bool isLiked;
  final User user;

  Like({
    required this.id,
    required this.isLiked,
    required this.user,
  });
}