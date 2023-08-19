import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/post/post_feed_type.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';
import '../post/post_to_widget_converter.dart';

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
              final post = state.posts[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: PostToWidgetConverter.convert(post),
              );
            },
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
