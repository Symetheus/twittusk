import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twittusk/presentation/screens/logic/feed_bloc/feed_bloc.dart';
import 'package:twittusk/presentation/widgets/tusk_item.dart';
import 'package:twittusk/theme/dimens.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FeedBloc>(context).add(FeedFetchEvent());
    return Scaffold(
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          switch (state.status) {
            case FeedStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            default:
              return ListView.builder(
                itemCount: state.tusks.length,
                padding: const EdgeInsets.all(Dimens.minPadding),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: Dimens.minPadding),
                    child: TuskItem(tusk: state.tusks[index]),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
