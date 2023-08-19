part of 'review_bloc.dart';

@immutable
abstract class ReviewEvent {}

class FetchReviewsForProduct extends ReviewEvent {
  final int productId;

  FetchReviewsForProduct(this.productId);
}

class FetchReviewsForVenue extends ReviewEvent {
  final int venueId;

  FetchReviewsForVenue(this.venueId);
}

class ExpandReview extends ReviewEvent {
  final int reviewId;
  ExpandReview(this.reviewId);
}

class CollapseReview extends ReviewEvent {
  final int reviewId;
  CollapseReview(this.reviewId);
}
