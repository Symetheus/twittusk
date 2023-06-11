import 'package:flutter/material.dart';
import 'package:twittusk/domain/models/tusk.dart';
import 'package:twittusk/presentation/widgets/action_icon.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

class TuskItem extends StatelessWidget {
  final Tusk tusk;
  final VoidCallback? onTapProfile;
  final VoidCallback? onTapComment;
  final VoidCallback? onTapLike;
  final VoidCallback? onTapDislike;
  final VoidCallback? onTapShare;

  const TuskItem({
    Key? key,
    required this.tusk,
    this.onTapProfile,
    this.onTapComment,
    this.onTapLike,
    this.onTapDislike,
    this.onTapShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).customColors.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimens.bigRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.standardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getProfileInfo(context),
            const SizedBox(height: Dimens.standardPadding),
            if(tusk.imageUri != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.standardRadius),
                child: Image.network(
                  tusk.imageUri!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: Dimens.standardPadding),
            ],
            Text(
              tusk.description,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: Dimens.standardPadding),
            _getBottomButton(context),
          ],
        ),
      ),
    );
  }

  Widget _getProfileInfo(BuildContext context) {
    return GestureDetector(
      onTap: onTapProfile,
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              tusk.profile.profilePicUri,
              width: Dimens.avatarSmall,
              height: Dimens.avatarSmall,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.minPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${tusk.profile.firstname} ${tusk.profile.lastname}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: Dimens.minPadding),
                    Text(
                      tusk.profile.username,
                      style: TextStyle(
                        color: Theme.of(context).customColors.secondary,
                        fontSize: Dimens.subtitleTextSize,
                        fontWeight: FontWeight.w400,
                        height: Dimens.subtitleLineHeight,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      tusk.getPublishAtStr(),
                      style: TextStyle(
                        color: Theme.of(context).customColors.textSecondary,
                        fontSize: Dimens.subtitleTextSize,
                        fontWeight: FontWeight.w400,
                        height: Dimens.subtitleLineHeight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBottomButton(BuildContext context) {
    return Row(
      children: [
        ActionIcon(
          color: Theme.of(context).customColors.secondary,
          iconAsset: "lib/assets/icons/comment.svg",
          label: tusk.getNbCommentStr(),
          onTap: onTapComment,
        ),
        const Spacer(),
        ActionIcon(
          color: Theme.of(context).customColors.secondary,
          iconAsset: "lib/assets/icons/like.svg",
          label: tusk.getNbLikesStr(),
          onTap: onTapLike,
        ),
        const SizedBox(width: Dimens.mediumPadding),
        ActionIcon(
          color: Theme.of(context).customColors.secondary,
          iconAsset: "lib/assets/icons/dislike.svg",
          label: tusk.getNbDislikesStr(),
          onTap: onTapDislike,
        ),
        const Spacer(),
        ActionIcon(
          color: Theme.of(context).customColors.secondary,
          iconAsset: "lib/assets/icons/share.svg",
          onTap: onTapShare,
        ),
      ],
    );
  }
}
