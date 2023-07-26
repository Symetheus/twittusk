import 'package:cloud_firestore/cloud_firestore.dart';

class TuskAddDto {
  final String description;
  final DateTime publishedAt;
  late DocumentReference user;
  final String? image;

  TuskAddDto({
    required this.description,
    required this.publishedAt,
    required this.user,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'publishedAt': publishedAt,
      'image': image,
      'user': user,
    };
  }
}
