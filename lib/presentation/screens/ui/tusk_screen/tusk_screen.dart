import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return BlocBuilder<TuskBloc, TuskState>(
      builder: (context, state) {
        switch (state.status) {
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
                      TuskItem(tusk: state.mainTusk!),

                    ],
                  ),
                ),
              ),
              bottomNavigationBar: CommentBottomBar(user: state.user!, tusk: state.mainTusk!),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
    return BlocConsumer<TuskBloc, TuskState>(
      listener: (context, state) {
         if (state.status == TuskStatus.initUser) {
          context.read<TuskBloc>().add(TuskCommentEvent(tuskId: tusk.id));
        } else if (state.status == TuskStatus.errorComment) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Theme.of(context).customColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<TuskBloc, TuskState>(
          builder: (context, state) {
            switch (state.status) {
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
                    title: const Text('Tusk'),
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.halfPadding),
                      child: ListView(
                        children: [
                          TuskItem(tusk: tusk),
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: CommentBottomBar(user: state.user!, tusk: tusk),
                );
              case TuskStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
                case TuskStatus.success:
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
                            return TuskItem(tusk: tusk);
                          }
                          return Padding(
                            padding: const EdgeInsets.all(Dimens.halfPadding),
                            child: TuskItem(tusk: state.tusks[index - 1]),
                          );
                        },
                      ),
                    ),
                  ),
                  bottomNavigationBar: CommentBottomBar(user: state.user!, tusk: tusk),
                );
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
                      child: ListView(
                        children: [
                          TuskItem(tusk: tusk),
                        ],
                      ),
                    ),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
