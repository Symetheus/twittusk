import 'package:twittusk/data/dto/tusk_dto.dart';
import 'package:twittusk/data/dto/user_session_dto.dart';
import '../dto/user_dto.dart';

abstract class TuskDataSource {
  Future<UserSessionDto> signIn(String email, String password);

  Future<UserSessionDto> signInWithGoogle();

  Future<UserSessionDto> signInWithTwitter();

  Future<UserSessionDto> signUp(String username, String email, String password);

  Future<void> addUser(UserDto user);

  Future<void> resetPassword(String email);

  Future<UserDto?> getUserById(String uid);

  Stream<List<TuskDto>> getTusks();
}