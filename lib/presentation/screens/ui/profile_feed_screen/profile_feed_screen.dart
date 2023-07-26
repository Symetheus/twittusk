import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/presentation/screens/logic/profile_feed_bloc/profile_feed_bloc.dart';
import 'package:twittusk/presentation/widgets/profile_info.dart';
import 'package:twittusk/presentation/widgets/tusk_item.dart';
import 'package:twittusk/theme/dimens.dart';

class ProfileFeedScreen extends StatelessWidget {
  const ProfileFeedScreen({
    required this.user,
    super.key,
  });

  final User user;

  static const routeName = '/profile-feed';

  static void navigate(BuildContext context, User user) {
    Navigator.pushNamed(context, routeName, arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileFeedBloc>(context).add(UserFeedFetchEvent(user));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(user.arobase),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProfileInfo(user: user),
            const SizedBox(height: Dimens.halfPadding),
            const Divider(
              thickness: Dimens.dividerThickness,
              height: 1,
            ),
            BlocBuilder<ProfileFeedBloc, ProfileFeedState>(
              builder: (context, state) {
                switch (state.status) {
                  case ProfileFeedStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  default:
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(Dimens.minPadding),
                        itemCount: state.tusks.length,
                        itemBuilder: (context, index) {
                          final tusk = state.tusks[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: Dimens.minPadding),
                            child: TuskItem(
                              tusk: state.tusks[index],
                              onTapLike: () => _onLikeOrDislike(context, tusk.id, true),
                              onTapDislike: () => _onLikeOrDislike(context, tusk.id, false),
                              onTapShare: () => _onShare(context, tusk.id),
                            ),
                          );
                        },
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onLikeOrDislike(BuildContext context, String uid, bool isLiked) {
    BlocProvider.of<ProfileFeedBloc>(context).add(FeedLikeEvent(
      tuskId: uid,
      isLiked: isLiked,
    ));
  }

  void _onShare(BuildContext context, String uid) {
    BlocProvider.of<ProfileFeedBloc>(context).add(FeedShareEvent(
      tuskId: uid,
    ));
  }
}
