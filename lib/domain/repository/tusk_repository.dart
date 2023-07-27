import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/domain/models/user_session.dart';
import '../../data/dto/tusk_add_dto.dart';
import '../models/like.dart';
import '../models/user.dart';

abstract class TuskRepository {
  // USER
  Future<UserSession> signIn(String email, String password);

  Future<UserSession> signInWithGoogle();

  Future<UserSession> signInWithTwitter();

  Future<UserSession> signUp(String username, String email, String password);

  Future<User?> getUserById(String uid);

  Future<void> addUser(User user);

  Future<void> resetPassword(String email);

  // TUSKS
  Stream<List<Tusk>> getTusks();

  Stream<List<Tusk>> getTusksByUser(User user);

  Future<List<Like>> getMyLikesByTusk(String tuskId);

  Future<void> addLike(String tuskId, bool isLiked);

  Future<void> removeLike(String likeId, String tuskId);

  Future<Uri> generateTuskDynamicLink(String tuskId);

  Future<User?> getCurrentUser();

  Future<void> addCommentToTusk(String tuskId, String comment, User user);

  Stream<List<Tusk>> getCommentsForTusk(String tweetId);

  Future<Tusk> getTuskById(String tuskId);

  Future<void> logout();

  Future<String> uploadImage(String path);

  Future<void> addTusk(String description, DateTime publishAt, String? image, User user);

  Future<void> updateUser(User user);
}