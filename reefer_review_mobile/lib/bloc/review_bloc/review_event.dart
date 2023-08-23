part of 'review_bloc.dart';

@immutable
abstract class ReviewEvent {}

class FetchReviewsForProduct extends ReviewEvent {
  final String productId;

  FetchReviewsForProduct(this.productId);
}

class FetchReviewsForVenue extends ReviewEvent {
  final String venueId;

  FetchReviewsForVenue(this.venueId);
}

class ExpandReview extends ReviewEvent {
  final String reviewId;
  ExpandReview(this.reviewId);
}

class CollapseReview extends ReviewEvent {
  final String reviewId;
  CollapseReview(this.reviewId);
}
