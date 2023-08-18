import 'package:reefer_review_mobile/data/post/post.dart';
import '../models/user.dart';

class GeneralPost extends Post {
  GeneralPost({
    required int postId,
    required User author,
    required DateTime date,
    required String content,
    required String image,
  }) : super(
          postId: postId,
          author: author,
          date: date,
          content: content,
          image: image,
        );
}
