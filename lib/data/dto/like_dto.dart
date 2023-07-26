import 'package:twittusk/data/dto/user_dto.dart';

import '../../domain/models/like.dart';

class LikeDto {
  final String uid;
  final bool isLiked;
  late UserDto user;

  LikeDto({
    required this.uid,
    required this.isLiked,
  });

  factory LikeDto.fromJson(Map<String, dynamic> json, String id) {
    return LikeDto(
      uid: id,
      isLiked: json['isLiked'],
    );
  }

  Like toLike() {
    return Like(
      id: uid,
      isLiked: isLiked,
      user: user.toUser(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLiked': isLiked,
    };
  }
}