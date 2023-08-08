import 'package:flutter/material.dart';
import '../../data/post/post_feed_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';
import '../../repositories/post_repository.dart/fake_post_repository_impl.dart';
import '../shared/loading_modal.dart';

class FollowingFeedScreen extends StatelessWidget {
  const FollowingFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FeedBloc(FakePostRepository())
          ..add(FetchPostsUsecase(PostFeedType.Following)),
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state is FeedLoading) {
              return const LoadingModal();
            } else if (state is FeedLoaded) {
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
        ),
      ),
    );
  }
}
