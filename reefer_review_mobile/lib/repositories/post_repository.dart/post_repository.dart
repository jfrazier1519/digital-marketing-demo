import '../../data/models/profile/profile.dart';
import '../../data/models/user/user.dart';
import '../../data/post/post.dart';
import '../../data/post/post_feed_type.dart';
import '../../data/post/post_with_entity.dart';

abstract class PostRepository {
  Future<List<Post>> getFeedPosts({PostFeedType? feedType, User user});
  Future<void> addPost(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> getPostsByProfileIdAndType(
      String authorId, ProfileType type);
}
