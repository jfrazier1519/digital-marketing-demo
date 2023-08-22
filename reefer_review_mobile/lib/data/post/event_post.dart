import 'package:reefer_review_mobile/data/post/post.dart';

import '../models/profile/profile.dart';

class EventPost extends Post {
  final String eventUrl;

  EventPost({
    required String postId,
    required String authorId,
    required ProfileType profileType,
    required DateTime date,
    required String content,
    required String image,
    required this.eventUrl,
  }) : super(
          profileType,
          postId: postId,
          authorId: authorId,
          date: date,
          content: content,
          image: image,
        );
}
