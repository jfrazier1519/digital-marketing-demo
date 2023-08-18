import 'package:reefer_review_mobile/data/models/review/review.dart';

import '../user.dart';

class ProductReview extends Review {
  final int productId;

  ProductReview({
    required int reviewId,
    required this.productId,
    required User reviewer,
    required String content,
    required DateTime date,
    required int rating,
    required String title,
  }) : super(
            reviewId: reviewId,
            reviewer: reviewer,
            content: content,
            date: date,
            rating: rating,
            title: title);
}
