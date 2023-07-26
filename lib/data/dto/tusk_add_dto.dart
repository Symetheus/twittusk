import 'package:twittusk/data/dto/user_dto.dart';

class TuskAddDto {
  TuskAddDto({
    required this.description,
    this.image,
    required this.publishedAt,
    required this.user,
  });

  final String description;
  final String? image;
  final DateTime publishedAt;
  final UserDto user;

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'image': image,
      'publishedAt': publishedAt,
    };
  }
}
