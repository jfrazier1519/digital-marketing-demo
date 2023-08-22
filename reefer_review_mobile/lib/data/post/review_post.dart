import 'package:reefer_review_mobile/data/post/post.dart';

class ReviewPost extends Post {
  final double reviewStars;

  ReviewPost({
    required String postId,
    required String authorId,
    required DateTime date,
    required String content,
    required String image,
    required this.reviewStars,
  }) : super(
          postId: postId,
          authorId: authorId,
          date: date,
          content: content,
          image: image,
        );
}
