import 'dart:async';

import 'package:twittusk/domain/repository/feed_repository.dart';
import '../../../domain/models/profile.dart';
import '../../../domain/models/tusk.dart';

class LocalTuskRepository implements TuskRepository {
  final StreamController<List<Tusk>> _controller =
  StreamController<List<Tusk>>();


  @override
  Stream<List<Tusk>> getTusks() {
    final profile = Profile(
        id: "1",
        lastname: "MUSK",
        username: "@ElonMusk",
        firstname: "Elon",
        bio: "This is Elon Musk !",
        profilePicUri: "https://www.thestreet.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTg4NzYwNTI4NjE5ODQxMDU2/elon-musk_4.jpg",
    );
    _controller.add(<Tusk>[
      Tusk(
          id: "20",
          title: "This is a title",
          description: "Bienvenue à tous dans ce cours sur SpaceX, l'une des entreprises les plus innovantes et passionnantes du monde de l'exploration spatiale. SpaceX, abréviation de Space Exploration Technologies Corp., a été fondée en 2002 par l'entrepreneur visionnaire Elon Musk dans le but de révolutionner l'industrie spatiale et de rendre l'exploration de l'espace plus accessible.",
          profile: profile,
          publishedAt: DateTime.now(),
          nbComments: 22,
          nbDislikes: 19647,
          nbLikes: 308729363,
      ),
      Tusk(
        id: "21",
        title: "This is ",
        description: "dqsdqsdds",
        profile: profile,
        publishedAt: DateTime.now(),
        nbComments: 3,
        nbDislikes: 20,
        nbLikes: 13786,
      )
    ]);
    return _controller.stream;
  }

}