import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/post/post_feed_type.dart';
import '../../bloc/feed_bloc/feed_bloc.dart';

class SuggestedFeedScreen extends StatefulWidget {
  const SuggestedFeedScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SuggestedFeedScreenState createState() => _SuggestedFeedScreenState();
}

class _SuggestedFeedScreenState extends State<SuggestedFeedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(FetchPostsUsecase(PostFeedType.Suggested));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const CircularProgressIndicator();
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
    );
  }
}
