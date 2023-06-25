import '../models/user.dart';

abstract class GoogleAuth {
  Future<User> signInWithGoogle();

  Future<User> signUpWithGoogle();
}