import 'package:reefer_review_mobile/data/models/user.dart';
import 'package:reefer_review_mobile/data/post/post.dart';

class EventPost extends Post {
  final String eventUrl;

  EventPost({
    required int postId,
    required User author,
    required DateTime date,
    required String content,
    required String image,
    required this.eventUrl,
  }) : super(
          postId: postId,
          author: author,
          date: date,
          content: content,
          image: image,
        );
}
