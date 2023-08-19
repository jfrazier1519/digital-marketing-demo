import '../../data/models/review/review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getAllReviewsForProduct(int productId);
  Future<List<Review>> getAllReviewsForVenue(int venueId);
  Future<Review> getReviewById(int reviewId);
  Future<void> addReview(Review review);
  Future<void> updateReview(Review review);
  Future<void> deleteReview(int reviewId);
}
