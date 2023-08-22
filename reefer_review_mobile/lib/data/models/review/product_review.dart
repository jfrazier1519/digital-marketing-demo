import 'package:reefer_review_mobile/data/models/review/review.dart';

import '../profile/profile.dart';

class ProductReview extends Review {
  final String productId;

  ProductReview({
    required String reviewId,
    required this.productId,
    required Profile reviewer,
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
