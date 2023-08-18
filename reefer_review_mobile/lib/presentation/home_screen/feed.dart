import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/post/post_feed_type.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';

class FeedScreen extends StatelessWidget {
  final PostFeedType feedType;

  const FeedScreen({required this.feedType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FeedBloc>().add(FetchPostsUsecase(feedType));

    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        if (state is FeedLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return state.posts[index].displayContent(context);
            },
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
