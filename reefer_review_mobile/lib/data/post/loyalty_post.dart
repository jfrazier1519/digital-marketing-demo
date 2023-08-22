import 'package:reefer_review_mobile/data/post/post.dart';

class LoyaltyPost extends Post {
  final String crystals;

  LoyaltyPost({
    required String postId,
    required String authorId,
    required DateTime date,
    required String content,
    required String image,
    required this.crystals,
  }) : super(
          postId: postId,
          authorId: authorId,
          date: date,
          content: content,
          image: image,
        );
}
