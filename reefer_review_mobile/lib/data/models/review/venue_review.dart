import 'package:reefer_review_mobile/data/models/review/review.dart';

import '../user.dart';

class VenueReview extends Review {
  final int venueId;

  VenueReview({
    required int reviewId,
    required this.venueId,
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
