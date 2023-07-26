import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twittusk/data/dto/user_dto.dart';

import '../../domain/models/tusk.dart';
import 'like_dto.dart';

class TuskDto {
  final String uid;
  final String description;
  final String? image;
  final DateTime publishedAt;
  late UserDto user;
  late final List<LikeDto> likes;
  late final List<TuskDto> comments;

  TuskDto({
    required this.uid,
    required this.description,
    this.image,
    required this.publishedAt,
    List<LikeDto>? likes,
    List<TuskDto>? comments,
  }) {
    this.likes = likes ?? [];
    this.comments = comments ?? [];
  }

  factory TuskDto.fromJson(Map<String, dynamic> json, String uid) {
    return TuskDto(
      uid: uid,
      description: json['description'],
      image: json['image'],
      publishedAt: (json['publishedAt'] as Timestamp).toDate(),
    );
  }

  Tusk toTusk(String uidCurrentUser) {
    return Tusk(
      id: uid,
      description: description,
      imageUri: image,
      publishedAt: publishedAt,
      profile: user.toUser(),
      nbLikes: likes.where((e) => e.isLiked).length,
      nbDislikes: likes.where((e) => !e.isLiked).length,
      nbComments: comments.length,
      isLiked: likes.any((e) => e.user.uid == uidCurrentUser && e.isLiked),
      isDisliked: likes.any((e) => e.user.uid == uidCurrentUser && !e.isLiked),
    );
  }
}