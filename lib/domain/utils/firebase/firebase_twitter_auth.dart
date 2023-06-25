import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:twittusk/data/extension/user_credential_mapping.dart';
import 'package:twittusk/domain/exceptions/auth_excpetion.dart';
import 'package:twittusk/domain/utils/twitter_auth.dart';
import '../../models/user.dart';

class FirebaseTwitterAuth implements TwitterAuth {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Future<User> signInWithTwitter() async {
    try{
      final twitterLogin = TwitterLogin(
          apiKey: dotenv.env['TWITTER_API_KEY'] ?? "",
          apiSecretKey: dotenv.env['TWITTER_API_KEY_SECRET'] ?? "",
          redirectURI: "twittusk://"
      );
      final authResult = await twitterLogin.login();
      final twitterAuthCredential = auth.TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      final credential = await _firebaseAuth.signInWithCredential(twitterAuthCredential);
      return credential.toUser();
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
        throw AuthException('The user has canceled the sign in process.');
      } else {
        throw AuthException(e.message ?? 'An error occurred while accessing the firebase auth.');
      }
    }
  }

  @override
  Future<User> signUpWithTwitter() async {
    final twitterLogin = TwitterLogin(
        apiKey: dotenv.env['TWITTER_API_KEY'] ?? "",
        apiSecretKey: dotenv.env['TWITTER_API_KEY_SECRET'] ?? "",
        redirectURI: "twittusk://"
    );
    final authResult = await twitterLogin.login();
    final credential = auth.TwitterAuthProvider.credential(
      accessToken: authResult.authToken ?? "",
      secret: authResult.authTokenSecret ?? "",
    );

    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: '${authResult.user!.name}@twitter.com',
      password: 'your-random-password1111!', // TODO
    );
    await userCredential.user?.linkWithCredential(credential);
    return userCredential.toUser();
  }
}