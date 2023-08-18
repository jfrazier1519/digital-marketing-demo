import 'package:flutter/material.dart';
import '../../data/post/post_feed_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';
import '../../repositories/post_repository.dart/fake_post_repository_impl.dart';
import '../post/post_to_widget_converter.dart';

class FollowingFeedScreen extends StatelessWidget {
  const FollowingFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FeedBloc(FakePostRepository())
          ..add(FetchPostsUsecase(PostFeedType.Following)),
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state is FeedLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];

                  return PostToWidgetConverter.convert(post);
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
