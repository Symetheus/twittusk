import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/presentation/screens/logic/feed_bloc/feed_bloc.dart';
import 'package:twittusk/presentation/widgets/profile_info.dart';
import 'package:twittusk/presentation/widgets/tusk_item.dart';
import 'package:twittusk/theme/dimens.dart';

class ProfileFeedScreen extends StatelessWidget {
  const ProfileFeedScreen({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FeedBloc>(context).add(FeedFetchEvent());
    return Scaffold(
      body: Column(
        children: [
          ProfileInfo(user: user),
          const SizedBox(height: Dimens.halfPadding),
          const Divider(thickness: Dimens.dividerThickness, height: 1,),
          BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              switch (state.status) {
                case FeedStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                default:
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.tusks.length,
                      padding: const EdgeInsets.all(Dimens.minPadding),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: Dimens.minPadding),
                          child: TuskItem(tusk: state.tusks[index]),
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
