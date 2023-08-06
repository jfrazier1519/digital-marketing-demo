import 'package:flutter/material.dart';
import 'package:reefer_review_mobile/data/post/post.dart';

class GeneralPost extends Post {
  GeneralPost(
      int postId, String author, DateTime date, String content, String image)
      : super(image,
            postId: postId, author: author, date: date, content: content);

  @override
  Widget displayContent() {
    return Column(
      children: [
        Image.network(image), // Display the image
        Text(content),
        // You can add more widgets, styling etc.
      ],
    );
  }
}
