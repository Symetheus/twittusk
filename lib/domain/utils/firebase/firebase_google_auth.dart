import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twittusk/data/extension/user_credential_mapping.dart';
import 'package:twittusk/domain/utils/google_auth.dart';
import '../../exceptions/auth_excpetion.dart';
import '../../models/user.dart';

class FirebaseGoogleAuth implements GoogleAuth {

  @override
  Future<User> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final credentials =  await auth.FirebaseAuth.instance.signInWithCredential(credential);
      return credentials.toUser();
    } on auth.FirebaseAuthException catch (e) {
      if(e.code == 'account-exists-with-different-credential') {
        throw AuthException('An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.');
      } else if(e.code == 'invalid-credential') {
        throw AuthException('The credential data is malformed or has expired.');
      } else {
        throw AuthException(e.message ?? 'An error occurred while accessing the firebase auth.');
      }
    } on PlatformException catch(e) {
      if(e.code == "sign_in_failed") {
        throw AuthException('This account does not exist.');
      } else {
        throw AuthException(e.message ?? 'An error occurred while accessing the firebase auth.');
      }
    }
  }

  @override
  Future<User> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }


}
