import 'package:firebase_auth/firebase_auth.dart';

abstract class GoogleAuth {
  Future<UserCredential> signInWithGoogle();
}