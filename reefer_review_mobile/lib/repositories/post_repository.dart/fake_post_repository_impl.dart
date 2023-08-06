import 'package:reefer_review_mobile/repositories/post_repository.dart/post_repository.dart';
import '../../data/post/post.dart';
import '../../data/post/event_post.dart';
import '../../data/post/general_post.dart';
import '../../data/post/loyalty_post.dart';
import '../../data/post/product_post.dart';
import '../../data/post/review_post.dart';

class FakePostRepository implements PostRepository {
  List<Post> _allPosts = [
    // Some initial fake posts can be added here.
  ];

  // Here's a simple type-based categorization
  List<Post> get _followingPosts {
    return _allPosts
        .where((post) => post is! ProductPost && post is! EventPost)
        .toList();
  }

  List<Post> get _suggestedPosts {
    return _allPosts
        .where((post) => post is ProductPost || post is EventPost)
        .toList();
  }

  @override
  Future<List<Post>> getPosts({PostFeedType? feedType}) async {
    switch (feedType) {
      case PostFeedType.Following:
        return _followingPosts;
      case PostFeedType.Suggested:
        return _suggestedPosts;
      default:
        return _allPosts;
    }
  }

  @override
  Future<void> addPost(Post post) async {
    _allPosts.add(post);
  }

  @override
  Future<void> updatePost(Post post) async {
    int index = _allPosts.indexWhere((p) => p.postId == post.postId);
    if (index != -1) {
      _allPosts[index] = post;
    }
  }

  @override
  Future<void> deletePost(int postId) async {
    _allPosts.removeWhere((p) => p.postId == postId);
  }
}

enum PostFeedType {
  Following,
  Suggested,
  All,
}
