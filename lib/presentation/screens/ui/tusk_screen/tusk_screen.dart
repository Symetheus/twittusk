import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/presentation/screens/logic/tusk_bloc/tusk_bloc.dart';
import 'package:twittusk/presentation/widgets/comment_bottom_bar.dart';
import 'package:twittusk/presentation/widgets/tusk_item.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

class TuskScreen extends StatelessWidget {
  const TuskScreen({
    required this.tusk,
    super.key,
  });

  final Tusk tusk;

  static const routeName = '/tusk';

  static void navigate(BuildContext context, Tusk tusk) {
    Navigator.pushNamed(context, routeName, arguments: tusk);
  }

  @override
  Widget build(BuildContext context) {
    context.read<TuskBloc>().add(InitUserEvent());

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
                      TuskItem(tusk: tusk),

                    ],
                  ),
                ),
              ),
              bottomNavigationBar: CommentBottomBar(user: state.user!, tusk: tusk),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
