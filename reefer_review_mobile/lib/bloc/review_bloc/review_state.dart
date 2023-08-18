part of 'review_bloc.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewsLoaded extends ReviewState {
  final List<Review> reviews;

  ReviewsLoaded(this.reviews);
}

class ReviewExpanded extends ReviewState {
  final int reviewId;
  ReviewExpanded(this.reviewId);
}

class ReviewCollapsed extends ReviewState {
  final int reviewId;
  ReviewCollapsed(this.reviewId);
}
