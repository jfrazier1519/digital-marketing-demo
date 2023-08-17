part of 'review_bloc.dart';

@immutable
abstract class ReviewEvent {}

class FetchReviews extends ReviewEvent {
  final int productId;

  FetchReviews(this.productId);
}

class ExpandReview extends ReviewEvent {
  final int reviewId;
  ExpandReview(this.reviewId);
}

class CollapseReview extends ReviewEvent {
  final int reviewId;
  CollapseReview(this.reviewId);
}
