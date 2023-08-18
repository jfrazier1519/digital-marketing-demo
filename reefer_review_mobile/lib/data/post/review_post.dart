import 'package:reefer_review_mobile/data/post/post.dart';
import '../models/user.dart';

class ReviewPost extends Post {
  final double reviewStars;

  ReviewPost({
    required int postId,
    required User author,
    required DateTime date,
    required String content,
    required String image,
    required this.reviewStars,
  }) : super(
          postId: postId,
          author: author,
          date: date,
          content: content,
          image: image,
        );
}
