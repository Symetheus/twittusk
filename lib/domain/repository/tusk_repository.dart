import 'package:twittusk/domain/models/tusk.dart';
import '../models/user.dart';

abstract class TuskRepository {
  Future<User> signIn(String email, String password);

  Future<void> resetPassword(String email);

  Stream<List<Tusk>> getTusks();

  Stream<List<Tusk>> getTusksByUser();
}