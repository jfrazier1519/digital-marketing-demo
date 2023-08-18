import 'package:reefer_review_mobile/data/post/post.dart';
import '../models/user.dart';

class ProductPost extends Post {
  final String productUrl;

  ProductPost({
    required int postId,
    required User author,
    required DateTime date,
    required String content,
    required String image,
    required this.productUrl,
  }) : super(
          postId: postId,
          author: author,
          date: date,
          content: content,
          image: image,
        );
}
