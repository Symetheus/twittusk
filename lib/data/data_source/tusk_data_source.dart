import 'package:firebase_auth/firebase_auth.dart';

abstract class TuskDataSource {
  Future<UserCredential> signIn(String email, String password);
}