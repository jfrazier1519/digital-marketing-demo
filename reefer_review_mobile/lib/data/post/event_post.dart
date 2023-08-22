import 'package:reefer_review_mobile/data/post/post.dart';

class EventPost extends Post {
  final String eventUrl;

  EventPost({
    required String postId,
    required String authorId,
    required DateTime date,
    required String content,
    required String image,
    required this.eventUrl,
  }) : super(
          postId: postId,
          authorId: authorId,
          date: date,
          content: content,
          image: image,
        );
}
