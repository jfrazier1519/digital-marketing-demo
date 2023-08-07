import 'package:flutter/material.dart';
import '../../data/post/post.dart';
import '../../repositories/post_repository.dart/fake_post_repository_impl.dart';
import '../../repositories/post_repository.dart/post_repository.dart';
import '../../data/post/post_feed_type.dart';

class FollowingFeedScreen extends StatefulWidget {
  const FollowingFeedScreen({super.key});

  @override
  _FollowingFeedScreenState createState() => _FollowingFeedScreenState();
}

class _FollowingFeedScreenState extends State<FollowingFeedScreen> {
  final PostRepository postRepository = FakePostRepository();
  late List<Post> posts;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  _fetchPosts() async {
    posts = await postRepository.getPosts(feedType: PostFeedType.Following);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return posts[index].displayContent(context);
        },
      ),
    );
  }
}
