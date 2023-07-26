import 'dart:async';
import 'package:twittusk/domain/models/like.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/domain/models/tusk.dart';
import '../../../domain/models/user_session.dart';

class LocalTuskRepository implements TuskRepository {
  final StreamController<List<Tusk>> _controller = StreamController<List<Tusk>>();

  @override
  Future<UserSession> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Stream<List<Tusk>> getTusks() {
    final profile = User(
      uid: "1",
      username: "Elon MUSK",
      arobase: "@ElonMusk",
      email: 'elon.musk@openai.com',
      profilePicUri: "https://www.thestreet.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTg4NzYwNTI4NjE5ODQxMDU2/elon-musk_4.jpg",
      bannerPicUri: '',
      bio: "This is Elon Musk !",
    );
    _controller.add(<Tusk>[
      Tusk(
        id: "19",
        description: "Bienvenue à tous dans ce cours sur SpaceX, l'une des entreprises les plus innovantes et passionnantes du monde de l'exploration spatiale. SpaceX, abréviation de Space Exploration Technologies Corp., a été fondée en 2002 par l'entrepreneur visionnaire Elon Musk dans le but de révolutionner l'industrie spatiale et de rendre l'exploration de l'espace plus accessible.",
        profile: profile,
        imageUri: "https://i.ytimg.com/vi/Dy68lCXLsGc/maxresdefault.jpg",
        publishedAt: DateTime(2023, 06, 11, 11, 0),
        nbComments: 22,
        nbDislikes: 19647,
        nbLikes: 308729363,
      ),
      Tusk(
          id: "20",
          description: "Bienvenue à tous dans ce cours sur SpaceX, l'une des entreprises les plus innovantes et passionnantes du monde de l'exploration spatiale. SpaceX, abréviation de Space Exploration Technologies Corp., a été fondée en 2002 par l'entrepreneur visionnaire Elon Musk dans le but de révolutionner l'industrie spatiale et de rendre l'exploration de l'espace plus accessible.",
          profile: profile,
          publishedAt: DateTime(2023, 06, 5, 12, 52),
          nbComments: 22,
          nbDislikes: 19647,
          nbLikes: 308729363,
      ),
    ]);
    return _controller.stream;
  }

  @override
  Stream<List<Tusk>> getTusksByUser(User user) {
    // TODO: implement getTusksByUser
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<UserSession> signUp(String username, String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> addUser(User user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<UserSession> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserSession> signInWithTwitter() {
    // TODO: implement signInWithTwitter
    throw UnimplementedError();
  }

  @override
  Future<User> getUserById(String uid) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<void> addLike(String tuskId, bool isLiked) {
    // TODO: implement addLike
    throw UnimplementedError();
  }

  @override
  Future<List<Like>> getMyLikesByTusk(String tuskId) {
    // TODO: implement getLikesByTusk
    throw UnimplementedError();
  }

  @override
  Future<void> removeLike(String likeId, String tuskId) {
    // TODO: implement removeLike
    throw UnimplementedError();
  }

  @override
  Future<Uri> generateTuskDynamicLink(String tuskId) {
    // TODO: implement generateTuskDynamicLink
    throw UnimplementedError();
  }


}
