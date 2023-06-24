import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:twittusk/domain/exceptions/auth_excpetion.dart';
import 'package:twittusk/domain/utils/twitter_auth.dart';

class FirebaseTwitterAuth implements TwitterAuth {

  @override
  Future<UserCredential> signInWithTwitter() async {
    try{
      final twitterLogin = TwitterLogin(
          apiKey: dotenv.env['TWITTER_API_KEY'] ?? "",
          apiSecretKey: dotenv.env['TWITTER_API_KEY_SECRET'] ?? "",
          redirectURI: "twittusk://"
      );
      final authResult = await twitterLogin.login();
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      return await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    } on FirebaseAuthException catch (e) {
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

}