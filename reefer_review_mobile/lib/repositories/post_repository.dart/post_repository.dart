import '../../data/models/user/user.dart';
import '../../data/post/post.dart';
import '../../data/post/post_feed_type.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts({PostFeedType? feedType, User user});
  Future<void> addPost(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> getPostsByAuthorId(String author);
}
