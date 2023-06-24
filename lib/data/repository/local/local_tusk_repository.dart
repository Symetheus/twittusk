import 'dart:async';
import 'package:twittusk/domain/repository/tusk_repository.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/domain/models/tusk.dart';

class LocalTuskRepository implements TuskRepository {
  final StreamController<List<Tusk>> _controller = StreamController<List<Tusk>>();

  @override
  Future<User> signIn(String email, String password) {
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
      Tusk(
        id: "21",
        description: "TU pues CONNNAARRDDD !!!!",
        profile: profile,
        publishedAt: DateTime(2023, 02, 11, 12, 52),
        nbComments: 3,
        nbDislikes: 20,
        nbLikes: 13786,
      )
    ]);
    return _controller.stream;
  }

  @override
  Stream<List<Tusk>> getTusksByUser() {
    // TODO: implement getTusksByUser
    throw UnimplementedError();
  }


}
