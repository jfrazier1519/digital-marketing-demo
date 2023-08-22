import 'package:reefer_review_mobile/data/post/post.dart';

class ProductPost extends Post {
  final String productUrl;

  ProductPost({
    required String postId,
    required String authorId,
    required DateTime date,
    required String content,
    required String image,
    required this.productUrl,
  }) : super(
          postId: postId,
          authorId: authorId,
          date: date,
          content: content,
          image: image,
        );
}
