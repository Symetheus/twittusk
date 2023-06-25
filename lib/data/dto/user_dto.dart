import '../../domain/models/user.dart';

class UserDto {
  final String uid;
  final String username;
  final String arobase;
  final String email;
  final String profilePicUri;
  final String bannerPicUri;
  final String bio;

  UserDto({
    required this.uid,
    required this.username,
    required this.arobase,
    required this.email,
    this.profilePicUri = "https://firebasestorage.googleapis.com/v0/b/twittusk.appspot.com/o/profils%2Fprofile-default.png?alt=media&token=ae11ba74-e84d-4a95-ac0d-5e1b572dda95",
    this.bannerPicUri = "https://firebasestorage.googleapis.com/v0/b/twittusk.appspot.com/o/banner%2Fbanner-default.jpg?alt=media&token=d88c5d06-3c62-4642-a392-48e6f534fc55",
    this.bio = "",
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      uid: json['uid'],
      username: json['username'],
      arobase: json['arobase'],
      email: json['email'],
      profilePicUri: json['profilePicUri'],
      bannerPicUri: json['bannerPicUri'],
      bio: json['bio'],
    );
  }

  factory UserDto.fromUser(User user) {
    return UserDto(
      uid: user.uid,
      username: user.username,
      arobase: user.arobase,
      email: user.email,
      profilePicUri: user.profilePicUri,
      bannerPicUri: user.bannerPicUri,
      bio: user.bio,
    );
  }

  User toUser() {
    return User(
      uid: uid,
      username: username,
      arobase: arobase,
      email: email,
      profilePicUri: profilePicUri,
      bannerPicUri: bannerPicUri,
      bio: bio,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'arobase': arobase,
      'email': email,
      'profilePicUri': profilePicUri,
      'bannerPicUri': bannerPicUri,
      'bio': bio,
    };
  }

}