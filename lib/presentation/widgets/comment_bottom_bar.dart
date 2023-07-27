import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/presentation/screens/logic/tusk_bloc/tusk_bloc.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

class CommentBottomBar extends StatelessWidget {
  const CommentBottomBar({
    required this.tusk,
    required this.user,
    super.key,
  });

  final User user;
  final Tusk tusk;

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();

    return BottomAppBar(
      color: Theme.of(context).customColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.standardPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: CircleAvatar(
                    maxRadius: Dimens.avatarXSmall,
                    backgroundImage: NetworkImage(
                      user.profilePicUri,
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.standardPadding),
                Expanded(
                  child: TextFormField(
                    scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    controller: commentController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                      label: Text('Écrire un commentaire'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context
                      .read<TuskBloc>()
                      .add(TuskAddCommentEvent(tusk: tusk, comment: commentController.text, user: user)),
                  child: const Text('Tusker'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
