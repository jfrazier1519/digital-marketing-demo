import 'package:reefer_review_mobile/data/models/user.dart';
import 'package:reefer_review_mobile/data/post/post.dart';

class LoyaltyPost extends Post {
  final String crystals;

  LoyaltyPost({
    required int postId,
    required User author,
    required DateTime date,
    required String content,
    required String image,
    required this.crystals,
  }) : super(
          postId: postId,
          author: author,
          date: date,
          content: content,
          image: image,
        );
}
