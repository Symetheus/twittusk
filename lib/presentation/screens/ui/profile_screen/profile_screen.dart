import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/dimens.dart';
import '../../logic/current_user_bloc/current_user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentUserBloc>(context).add(GetCurrentUserEvent());
    return BlocConsumer<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch(state.status) {
          case CurrentUserStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case CurrentUserStatus.success:
            return Column(
                children: [
                  Image.network(
                    state.user!.bannerPicUri,
                    width: double.infinity,
                    height: Dimens.bannerMaxHeight,
                    fit: BoxFit.fitWidth,
                  ),
                ]
            );

          default:
            return Container();
        }

      },
    );
  }
}
