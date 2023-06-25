import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/user_session.dart';

class UserSessionDto {
  final String uid;
  final String? email;
  final String? displayName;
  final bool isVerified;
  final bool isAnonymous;
  final String? providerId;
  final String? refreshToken;
  final String? tenantId;

  UserSessionDto({
    required this.uid,
    this.displayName,
    this.email,
    this.isVerified = false,
    this.isAnonymous = false,
    this.providerId,
    this.refreshToken,
    this.tenantId,
  });

  factory UserSessionDto.fromUserCredential(UserCredential userCredential) {
    return UserSessionDto(
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

  UserSession toUserSession() {
    return UserSession(
      uid: uid,
      displayName: displayName,
      email: email,
      isVerified: isVerified,
      isAnonymous: isAnonymous,
      providerId: providerId,
      refreshToken: refreshToken,
      tenantId: tenantId,
    );
  }
}