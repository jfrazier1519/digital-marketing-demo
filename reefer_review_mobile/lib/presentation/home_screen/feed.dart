import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../../data/post/post_feed_type.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';
import '../post/post_to_widget_converter.dart';
import '../shared/custom_loading_indicator.dart';

class FeedScreen extends StatelessWidget {
  final PostFeedType feedType;

  const FeedScreen({required this.feedType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (userContext, userState) {
        if (userState is UserLoaded) {
          // Only send the FetchPostsUsecase event if the user is loaded
          context
              .read<FeedBloc>()
              .add(FetchPostsUsecase(feedType: feedType, user: userState.user));

          // Return your FeedBloc BlocBuilder
          return BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state is FeedLoaded) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: PostToWidgetConverter.convert(post),
                    );
                  },
                );
              } else {
                return const Center(
                    child: Text('Something went wrong with fetching posts'));
              }
            },
          );
        } else {
          // If UserBloc's state is not UserLoaded, show the loading indicator
          return const Center(
            child: CustomLoadingIndicator(),
          );
        }
      },
    );
  }
}
