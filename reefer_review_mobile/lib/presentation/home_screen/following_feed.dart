import 'package:flutter/material.dart';
import '../../data/post/post_feed_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';
import '../shared/loading_modal.dart';

class FollowingFeedScreen extends StatefulWidget {
  const FollowingFeedScreen({super.key});

  @override
  _FollowingFeedScreenState createState() => _FollowingFeedScreenState();
}

class _FollowingFeedScreenState extends State<FollowingFeedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(FetchPostsUsecase(PostFeedType.Following));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return LoadingModal(); // Return the custom loading modal
          } else if (state is FeedLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return state.posts[index].displayContent(context);
              },
            );
          } else {
            return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
