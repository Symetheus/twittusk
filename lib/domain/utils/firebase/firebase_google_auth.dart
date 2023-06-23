import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twittusk/domain/exceptions/auth_exception.dart';
import 'package:twittusk/domain/utils/google_auth.dart';

class FirebaseGoogleAuth implements GoogleAuth {

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try{
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'account-exists-with-different-credential') {
        throw AuthException('An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.');
      } else if(e.code == 'invalid-credential') {
        throw AuthException('The credential data is malformed or has expired.');
      } else {
        throw AuthException(e.message ?? 'An error occurred while accessing the firebase auth.');
      }
    }
  }
}
