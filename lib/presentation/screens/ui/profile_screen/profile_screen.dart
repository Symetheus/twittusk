import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twittusk/presentation/screens/ui/login_screen/login_screen.dart';
import 'package:twittusk/theme/theme.dart';

import '../../../../theme/dimens.dart';
import '../../logic/current_user_bloc/current_user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const topSpacing = Dimens.bannerUltraHeight - Dimens.avatarXXXLarge / 2;
    BlocProvider.of<CurrentUserBloc>(context).add(GetCurrentUserEvent());
    return BlocConsumer<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {
        if (state.status == CurrentUserStatus.logoutSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case CurrentUserStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case CurrentUserStatus.success:
            return Stack(
              children: [
                Column(
                    children: [
                      Image.network(
                        state.user!.bannerPicUri,
                        width: double.infinity,
                        height: Dimens.bannerUltraHeight,
                        fit: BoxFit.fitWidth,
                      ),
                    ]
                ),
                Positioned(
                  top: topSpacing,
                  left: MediaQuery.of(context).size.width / 2 - Dimens.avatarXXXLarge,
                  child: Column(
                    children: [
                      Container(
                        height: Dimens.avatarXXXLarge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).customColors.background,
                            width: Dimens.dividerThickness,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: Dimens.avatarXXXLarge,
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(state.user!.profilePicUri),
                        ),
                      ),
                      Text(
                        state.user!.username,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                      '@${state.user!.arobase}',
                        style: TextStyle(
                          color: Theme.of(context).customColors.secondary,
                          fontSize: Dimens.standardTextSize,
                          fontWeight: FontWeight.w400,
                          height: Dimens.subtitleLineHeight,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimens.doublePadding),
                  child: IconButton(
                    onPressed: () => _onLogout(context),
                    icon: const Icon(Icons.logout),
                    color: Theme.of(context).customColors.onBackground,
                    iconSize: Dimens.smallIconSize,
                  ),
                ),
              ],
            );

            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(Dimens.doublePadding),
                child: IconButton(
                  onPressed: () => _onLogout(context),
                  icon: Icon(Icons.logout),
                  color: Theme.of(context).customColors.onBackground,
                  iconSize: Dimens.smallIconSize,
                ),
              ),
              // Image.network(
              //   state.user!.bannerPicUri,
              //   width: double.infinity,
              //   height: Dimens.bannerMaxHeight,
              //   fit: BoxFit.fitWidth,
              // ),
            ]);
          default:
            return Container();
        }
      },
    );
  }

  void _onLogout(BuildContext context) {
    BlocProvider.of<CurrentUserBloc>(context).add(CurrentUserLogoutEvent());
  }

}
