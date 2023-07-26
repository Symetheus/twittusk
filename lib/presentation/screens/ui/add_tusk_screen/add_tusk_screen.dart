import 'package:flutter/material.dart';
import 'package:twittusk/presentation/widgets/littleButton.dart';
import 'package:twittusk/theme/dimens.dart';
import 'package:twittusk/theme/theme.dart';

import '../../../../domain/models/user.dart';
import '../../../widgets/profile_info.dart';

class AddTuskScreen extends StatelessWidget {
  const AddTuskScreen({Key? key}) : super(key: key);

  static const routeName = '/add-tusk';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).customColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: Theme.of(context).customColors.onBackground,
          iconSize: Dimens.smallIconSize,
        ),
        title: const Text("Create Tusk"),
        actions: [
          LittleButton.primary(
            text: 'Tusker',
            onPressed: () {},
            style: TextButton.styleFrom(
              maximumSize: const Size(Dimens.littleButtonMinWidth,
                  Dimens.littleButtonMinInteractiveTouch),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: Dimens.mediumPadding,
                left: Dimens.mediumPadding,
                right: Dimens.mediumPadding,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).customColors.surface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Dimens.smallRadius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.standardPadding),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          user.profilePicUri,
                          width: Dimens.avatarSmall,
                          height: Dimens.avatarSmall,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: Dimens.standardPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  user.username,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: Dimens.minPadding),
                                Text(
                                  user.arobase,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .customColors
                                        .secondary,
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
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.mediumPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).customColors.surface,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Dimens.smallRadius),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.standardPadding),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () => {},
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          color: Theme.of(context).customColors.onBackground,
                          iconSize: Dimens.smallIconSize,
                        ),
                        Text('Add Tusk Screen'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
