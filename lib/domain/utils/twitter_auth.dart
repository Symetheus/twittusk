import '../models/user.dart';

abstract class TwitterAuth {
  Future<User> signInWithTwitter();

  Future<User> signUpWithTwitter();
}