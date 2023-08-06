import '../../data/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<void> addPost(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(int postId);
}
