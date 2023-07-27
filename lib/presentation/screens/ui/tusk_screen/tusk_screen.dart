import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';
import 'package:twittusk/presentation/screens/logic/tusk_bloc/tusk_bloc.dart';
import 'package:twittusk/presentation/widgets/comment_bottom_bar.dart';
import 'package:twittusk/presentation/widgets/tusk_item.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

class TuskScreen extends StatelessWidget {
  const TuskScreen({
    required this.idTusk,
    super.key,
  });

  final String idTusk;
  static const routeName = '/tusk';

  static void navigate(BuildContext context, String id) {
    Navigator.pushNamed(context, routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    context.read<TuskBloc>().add(InitUserEvent(tuskId: idTusk));

    return BlocConsumer<TuskBloc, TuskState>(
      listener: (context, state) {
        if (state.status == TuskStatus.initUser) {
          context.read<TuskBloc>().add(TuskCommentEvent(tuskId: state.mainTusk!.id));
        } else if (state.status == TuskStatus.errorComment) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Theme.of(context).customColors.error,
            ),
          );
        } else if (state.status == TuskStatus.dynamicLinkSuccess) {
          Share.share(state.dynamicLink!.toString());
        }
      },
      builder: (context, state) {
        return BlocBuilder<TuskBloc, TuskState>(
          builder: (context, state) {
            switch (state.status) {
              case TuskStatus.initial:
                return const CircularProgressIndicator();
              case TuskStatus.initUser:
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).customColors.background,
                    leading: IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: const Text('Tweet'),
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.halfPadding),
                      child: ListView(
                        children: [
                          TuskItem(
                            tusk: state.mainTusk!,
                            onTapDislike: () => _onLikeOrDislike(context, state.mainTusk!.id, false),
                            onTapLike: () => _onLikeOrDislike(context, state.mainTusk!.id, true),
                            onTapShare: () => _onShare(context, state.mainTusk!.id),
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: CommentBottomBar(user: state.user!, tusk: state.mainTusk!),
                );
              case TuskStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              //case TuskStatus.success:
              default:
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).customColors.background,
                    leading: IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: const Text('Tusk'),
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.halfPadding),
                      child: ListView.builder(
                        itemCount: state.tusks.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return TuskItem(
                              tusk: state.mainTusk!,
                              onTapDislike: () => _onLikeOrDislike(context, state.mainTusk!.id, false),
                              onTapLike: () => _onLikeOrDislike(context, state.mainTusk!.id, true),
                              onTapShare: () => _onShare(context, state.mainTusk!.id),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(Dimens.halfPadding),
                            child: TuskItem(
                              tusk: state.tusks[index - 1],
                              onTapDislike: () => _onLikeOrDislike(context, state.mainTusk!.id, false),
                              onTapLike: () => _onLikeOrDislike(context, state.mainTusk!.id, true),
                              onTapComment: () => TuskScreen.navigate(context, state.mainTusk!.id),
                              onTapShare: () => _onShare(context, state.mainTusk!.id),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  bottomNavigationBar: CommentBottomBar(user: state.user!, tusk: state.mainTusk!),
                );
            }
          },
        );
      },
    );
  }

  void _onLikeOrDislike(BuildContext context, String uid, bool isLiked) {
    BlocProvider.of<TuskBloc>(context).add(TuskLikeEvent(
      tuskId: uid,
      isLiked: isLiked,
    ));
    BlocProvider.of<TuskBloc>(context).add(TuskCommentEvent(tuskId: uid));
  }

  void _onShare(BuildContext context, String uid) {
    BlocProvider.of<TuskBloc>(context).add(TuskShareEvent(
      tuskId: uid,
    ));
    BlocProvider.of<TuskBloc>(context).add(TuskCommentEvent(tuskId: uid));
  }
}
