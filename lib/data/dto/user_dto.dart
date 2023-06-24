import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../domain/models/user.dart';

class UserDto {
  final String uid;
  final String? displayName;
  final String email;
  final bool isVerified;
  final bool isAnonymous;
  final String providerId;
  final String? refreshToken;
  final String? tenantId;

  UserDto({
    required this.uid,
    this.displayName,
    required this.email,
    this.isVerified = false,
    this.isAnonymous = false,
    required this.providerId,
    this.refreshToken,
    this.tenantId,
  });

  factory UserDto.fromUserCredential(auth.UserCredential userCredential) {
    return UserDto(
      uid: userCredential.user!.uid,
      displayName: userCredential.user!.displayName,
      email: userCredential.user!.email!,
      isVerified: userCredential.user!.emailVerified,
      isAnonymous: userCredential.user!.isAnonymous,
      providerId: userCredential.user!.providerData[0].providerId,
      refreshToken: userCredential.user!.refreshToken,
      tenantId: userCredential.user!.tenantId,
    );
  }

  User toUser() {
    return User(
      uid: uid,
      email: email,
      username: email,
      arobase: '',
      profilePicUri: '',
      bannerPicUri: '',
      bio: '',
    );
  }
}