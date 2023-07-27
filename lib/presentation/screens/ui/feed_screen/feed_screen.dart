import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:twittusk/presentation/screens/logic/feed_bloc/feed_bloc.dart';
import 'package:twittusk/presentation/screens/ui/profile_feed_screen/profile_feed_screen.dart';
import 'package:twittusk/presentation/screens/ui/tusk_screen/tusk_screen.dart';
import 'package:twittusk/presentation/widgets/tusk_item.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

import '../add_tusk_screen/add_tusk_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();

}

class _FeedScreenState extends State<FeedScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FeedBloc>(context).add(FeedFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    _initDynamicLinks(context);

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<FeedBloc, FeedState>(
          listener: (context, state) {
            if (state.status == FeedStatus.dynamicLinkSuccess) {
              Share.share(state.dynamicLink!.toString());
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case FeedStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              default:
                return ListView.builder(
                  itemCount: state.tusks.length,
                  padding: const EdgeInsets.all(Dimens.minPadding),
                  itemBuilder: (context, index) {
                    final tusk = state.tusks[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: Dimens.minPadding),
                      child: TuskItem(
                          tusk: tusk,
                          onTapComment: () => TuskScreen.navigate(context, tusk.id),
                          onTapProfile: () => ProfileFeedScreen.navigate(context, tusk.profile),
                          onTapLike: () => _onLikeOrDislike(context, tusk.id, true),
                          onTapDislike: () => _onLikeOrDislike(context, tusk.id, false),
                          onTapShare: () => _onShare(context, tusk.id),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () => _onAddTuskScreen(context),
          backgroundColor: Theme.of(context).customColors.primary,
          child: SvgPicture.asset(
            'lib/assets/icons/tusk-solid.svg',
            width: Dimens.mediumIconSize,
          )
        ),
      )
    );
  }

  void _onAddTuskScreen(BuildContext context) {
    AddTuskScreen.navigateTo(context);
  }

  void _onLikeOrDislike(BuildContext context, String uid, bool isLiked) {
    BlocProvider.of<FeedBloc>(context).add(FeedLikeEvent(
      tuskId: uid,
      isLiked: isLiked,
    ));
    BlocProvider.of<FeedBloc>(context).add(FeedFetchEvent());

  }

  void _onShare(BuildContext context, String uid) {
    BlocProvider.of<FeedBloc>(context).add(FeedShareEvent(
      tuskId: uid,
    ));
    BlocProvider.of<FeedBloc>(context).add(FeedFetchEvent());

  }

  void _initDynamicLinks(BuildContext context) async {
    final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final deepLink = initialLink.link.toString().split("/").last;
      _navigateToTuskScreen(context, deepLink);
    }

    FirebaseDynamicLinks.instance.onLink.listen((pendingDynamicLinkData) {
      final Uri deepLink = pendingDynamicLinkData.link;
      final taskId = deepLink.toString().split("/").last;
      print(taskId);
      _navigateToTuskScreen(context, taskId);
    });
  }

  void _navigateToTuskScreen(BuildContext context, String taskId) {
    TuskScreen.navigate(context, taskId);
  }
}
