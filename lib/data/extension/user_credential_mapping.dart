import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/domain/models/user_session.dart';

extension UserCredentialMapping on auth.UserCredential {

  UserSession toUserSession() {
    return UserSession(
      uid: user!.uid,
      displayName: user!.displayName,
      email: user!.email,
      isAnonymous: user!.isAnonymous,
      isVerified: user!.emailVerified,
      providerId: user!.providerData[0].providerId,
      refreshToken: user!.refreshToken,
      tenantId: user!.tenantId,
    );
  }
}