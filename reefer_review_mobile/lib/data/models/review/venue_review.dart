import 'package:reefer_review_mobile/data/models/profile/profile.dart';
import 'package:reefer_review_mobile/data/models/review/review.dart';

class VenueReview extends Review {
  final String venueId;

  VenueReview({
    required String reviewId,
    required this.venueId,
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
