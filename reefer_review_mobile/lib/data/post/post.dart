abstract class Post {
  final String postId;
  final String authorId;
  final DateTime date;
  final String content;
  final String image;

  Post({
    required this.postId,
    required this.authorId,
    required this.date,
    required this.content,
    required this.image,
  });
}
