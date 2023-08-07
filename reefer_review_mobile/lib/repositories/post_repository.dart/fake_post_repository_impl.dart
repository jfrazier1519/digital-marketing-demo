import 'package:reefer_review_mobile/repositories/post_repository.dart/post_repository.dart';
import '../../data/post/post.dart';
import '../../data/post/event_post.dart';
import '../../data/post/general_post.dart';
import '../../data/post/loyalty_post.dart';
import '../../data/post/product_post.dart';
import '../../data/post/review_post.dart';
import '../../data/user.dart';
import 'package:reefer_review_mobile/res/images.dart';
import '../../data/post/post_feed_type.dart';

class FakePostRepository implements PostRepository {
  List<Post> _allPosts = [];

  FakePostRepository() {
    User dummyUser = User(
      'john.doe@example.com',
      'userID1',
      'John Doe',
      dummyProfileImage,
    );

    _allPosts = [
      GeneralPost(
        postId: 1,
        author: dummyUser,
        date: DateTime.now(),
        content: 'This is a general post.',
        image: dummyGeneralPostImage,
      ),
      EventPost(
        postId: 2,
        author: dummyUser,
        date: DateTime.now(),
        content: 'This is an event post.',
        image: dummyEventPostImage,
        eventUrl: 'event_screen_route',
      ),
      LoyaltyPost(
        postId: 3,
        author: dummyUser,
        date: DateTime.now(),
        content: 'This is a loyalty post.',
        image: dummyLoyaltyPostImage,
        crystals: '5',
      ),
      ProductPost(
        postId: 4,
        author: dummyUser,
        date: DateTime.now(),
        content: 'This is a product post.',
        image: dummyProductPostImage,
        productUrl: 'product_screen_route',
      ),
      ReviewPost(
        postId: 5,
        author: dummyUser,
        date: DateTime.now(),
        content: 'This is a review post.',
        image: dummyReviewPostImage,
        reviewStars: 4.5,
      ),
    ];
  }

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
