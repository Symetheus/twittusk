import 'package:twittusk/data/dto/like_dto.dart';
import 'package:twittusk/data/dto/tusk_dto.dart';
import 'package:twittusk/data/dto/user_session_dto.dart';
import '../dto/user_dto.dart';

abstract class TuskDataSource {
  // USER
  Future<UserSessionDto> signIn(String email, String password);

  Future<UserSessionDto> signInWithGoogle();

  Future<UserSessionDto> signInWithTwitter();

  Future<UserSessionDto> signUp(String username, String email, String password);

  Future<UserDto?> getCurrentUser();

  Future<void> addUser(UserDto user);

  Future<void> resetPassword(String email);

  Future<UserDto?> getUserById(String uid);

  // TUSKS
  Future<List<LikeDto>> getLikesByTusk(String tuskId);

  Stream<List<TuskDto>> getTusks();

  Stream<List<TuskDto>> getTusksByUser(UserDto user);

  Future<void> addLikeTusk(LikeDto like, String tuskId);

  Future<void> removeLikeTusk(String likeId, String tuskId);

  Future<Uri> generateTuskDynamicLink(String tuskId);
}