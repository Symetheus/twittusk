import 'package:flutter/material.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/presentation/widgets/action_icon.dart';
import 'package:twittusk/presentation/widgets/littleButton.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildContent(context),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    const topSpacing = Dimens.bannerMaxHeight - Dimens.avatarSmall;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerRight,
      children: [
        Image.network(
          user.bannerPicUri,
          width: double.infinity,
          height: Dimens.bannerMaxHeight,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          top: topSpacing,
          right: Dimens.halfPadding,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).customColors.background,
                width: Dimens.dividerThickness,
              ),
            ),
            child: CircleAvatar(
              radius: Dimens.avatarSmall,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(user.profilePicUri),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) => Padding(
        padding: const EdgeInsets.all(Dimens.halfPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '@${user.arobase}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).customColors.secondary),
                  ),
                  const SizedBox(height: Dimens.standardPadding),
                  Text(user.bio),
                ],
              ),
            ),
            false
                ? LittleButton.primary(
                    onPressed: () {},
                    text: 'Follusk',
                  )
                : LittleButton.secondary(
                    onPressed: () {},
                    text: 'Follusked',
                  ),
          ],
        ),
      );

  Widget _buildFooter(BuildContext context) => Padding(
        padding: const EdgeInsets.all(Dimens.halfPadding),
        child: Row(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                ActionIcon(
                  color: Theme.of(context).customColors.textSecondary,
                  iconAsset: "lib/assets/icons/account.svg",
                  label: '100M Follusk', // TODO: replace with real data
                  onTap: () {},
                ),
                const SizedBox(width: Dimens.mediumPadding),
                ActionIcon(
                  color: Theme.of(context).customColors.textSecondary,
                  iconAsset: "lib/assets/icons/account.svg",
                  label: '0 Folluskink', // TODO: replace with real data
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      );
}
