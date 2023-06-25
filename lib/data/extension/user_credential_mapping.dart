import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:twittusk/domain/models/user.dart';

extension UserCredentialMapping on auth.UserCredential {

  User toUser() {
    return User(
      uid: user!.uid,
      email: user!.email ?? '',
      username: user!.displayName ?? '',
      arobase: '',
      profilePicUri: '',
      bannerPicUri: '',
      bio: '',
    );
  }
}