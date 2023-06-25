import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/domain/models/user_session.dart';
import '../models/user.dart';

abstract class TuskRepository {
  Future<UserSession> signIn(String email, String password);

  Future<UserSession> signInWithGoogle();

  Future<UserSession> signInWithTwitter();

  Future<UserSession> signUp(String username, String email, String password);

  Future<User?> getUserById(String uid);

  Future<void> addUser(User user);

  Future<void> resetPassword(String email);

  Stream<List<Tusk>> getTusks();

  Stream<List<Tusk>> getTusksByUser();
}