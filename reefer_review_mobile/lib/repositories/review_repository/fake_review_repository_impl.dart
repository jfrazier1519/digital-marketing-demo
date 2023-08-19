import 'package:reefer_review_mobile/repositories/review_repository/review_repository.dart';
import '../../data/models/review/review.dart';
import '../../data/models/review/product_review.dart';
import '../../data/models/review/venue_review.dart';
import '../../data/models/user.dart';
import '../../res/images.dart';

class FakeReviewRepository implements ReviewRepository {
  List<Review> _allReviews = [];

  FakeReviewRepository() {
    User dummyReviewer = User(
      userId: 'userID2',
      email: 'alice.smith@example.com',
      name: 'Alice Smith',
      profileImageUrl: profileImage,
    );

    User dummyReviewer2 = User(
      userId: 'userID3',
      email: 'john.smith@example.com',
      name: 'John Smith',
      profileImageUrl: dummyProfileImage,
    );

    //TODO: add other review types here as they're needed
    _allReviews = [
      ProductReview(
          reviewId: 1,
          productId: 1,
          reviewer: dummyReviewer,
          content: 'Great product! Really enjoyed it.',
          date: DateTime.now(),
          rating: 4,
          title: 'Delicious Gummies'),
      ProductReview(
          reviewId: 2,
          productId: 1,
          reviewer: dummyReviewer2,
          content: 'It was alright, could be better.',
          date: DateTime.now(),
          rating: 2,
          title: 'The Worst'),
      ProductReview(
          reviewId: 3,
          productId: 3,
          reviewer: dummyReviewer,
          content: 'Fantastic! I recommend it to everyone.',
          date: DateTime.now(),
          rating: 5,
          title: '10/10 JUST DO IT'),
      VenueReview(
          reviewId: 100,
          venueId: 1,
          reviewer: dummyReviewer,
          content: 'Great venue, loved the atmosphere.',
          date: DateTime.now(),
          rating: 5,
          title: 'Perfect Spot'),
      VenueReview(
          reviewId: 101,
          venueId: 1,
          reviewer: dummyReviewer2,
          content: 'The venue was too crowded for my liking.',
          date: DateTime.now(),
          rating: 2,
          title: 'Too Packed'),
    ];
  }

  @override
  Future<List<ProductReview>> getAllReviewsForProduct(int productId) async {
    return _allReviews
        .where((review) =>
            review is ProductReview && review.productId == productId)
        .map((review) => review as ProductReview)
        .toList();
  }

  @override
  Future<List<VenueReview>> getAllReviewsForVenue(int venueId) async {
    return _allReviews
        .where((review) => review is VenueReview && review.venueId == venueId)
        .map((review) => review as VenueReview)
        .toList();
  }

  @override
  Future<Review> getReviewById(int reviewId) async {
    return _allReviews.firstWhere((review) => review.reviewId == reviewId);
  }

  @override
  Future<void> addReview(Review review) async {
    _allReviews.add(review);
  }

  @override
  Future<void> deleteReview(int reviewId) async {
    _allReviews.removeWhere((review) => review.reviewId == reviewId);
  }

  @override
  Future<void> updateReview(Review updatedReview) async {
    int index = _allReviews
        .indexWhere((review) => review.reviewId == updatedReview.reviewId);
    if (index != -1) {
      _allReviews[index] = updatedReview;
    }
  }
}
