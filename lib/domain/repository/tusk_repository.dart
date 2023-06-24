import 'package:firebase_auth/firebase_auth.dart';
import 'package:twittusk/domain/models/tusk.dart';

abstract class TuskRepository {
  Future<UserCredential> signIn(String email, String password);

  Stream<List<Tusk>> getTusks();

  Stream<List<Tusk>> getTusksByUser();
}