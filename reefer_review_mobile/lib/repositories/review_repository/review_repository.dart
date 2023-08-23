import '../../data/models/review/review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getAllReviewsForProduct(String productId);
  Future<List<Review>> getAllReviewsForVenue(String venueId);
  Future<Review> getReviewById(String reviewId);
  Future<void> addReview(Review review);
  Future<void> updateReview(Review review);
  Future<void> deleteReview(String reviewId);
}
