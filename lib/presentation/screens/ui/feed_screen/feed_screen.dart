import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:twittusk/presentation/screens/logic/feed_bloc/feed_bloc.dart';
import 'package:twittusk/presentation/widgets/tusk_item.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FeedBloc>(context).add(FeedFetchEvent());
    return Scaffold(
      body: BlocConsumer<FeedBloc, FeedState>(
        listener: (context, state) {
          if (state.status == FeedStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Theme.of(context).customColors.error,
              ),
            );
          } else if (state.status == FeedStatus.dynamicLinkSuccess) {
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
                  return Padding(
                    padding: const EdgeInsets.only(top: Dimens.minPadding),
                    child: TuskItem(
                        tusk: state.tusks[index],
                        onTapLike: () => _onLikeOrDislike(context, state.tusks[index].id, true),
                        onTapDislike: () => _onLikeOrDislike(context, state.tusks[index].id, false),
                        onTapShare: () => _onShare(context, state.tusks[index].id),
                    ),
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: _onPressed,
          backgroundColor: Theme.of(context).customColors.primary,
          child: SvgPicture.asset(
            'lib/assets/icons/tusk-solid.svg',
            width: Dimens.mediumIconSize,
          )
        ),
      )
    );
  }

  void _onPressed() {
  }

  void _onLikeOrDislike(BuildContext context, String uid, bool isLiked) {
    BlocProvider.of<FeedBloc>(context).add(FeedLikeEvent(
      tuskId: uid,
      isLiked: isLiked,
    ));
  }

  void _onShare(BuildContext context, String uid) {
    BlocProvider.of<FeedBloc>(context).add(FeedShareEvent(
      tuskId: uid,
    ));
  }
}
