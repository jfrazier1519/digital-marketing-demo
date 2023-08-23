import 'package:reefer_review_mobile/repositories/review_repository/review_repository.dart';
import '../../data/models/review/review.dart';
import '../../data/models/review/product_review.dart';
import '../../data/models/review/venue_review.dart';

class FakeReviewRepository implements ReviewRepository {
  List<Review> _allReviews = [];

  FakeReviewRepository() {
    _allReviews = [
      ProductReview(
          reviewId: '1',
          productId: '12',
          reviewerId: '1',
          content:
              'I love this bronze pipe an how easy it is to diassemble and travel around with. The only down side, and why I am not giving this 4 stars, is that it gets too hot when I light the Flower. I have burned my lips many many times and have since stopped using it.',
          date: DateTime.now(),
          rating: 3,
          title: 'Good but too hot'),
      ProductReview(
          reviewId: '2',
          productId: '7',
          reviewerId: '2',
          content:
              'These Dab Carts never let me down and this strain is amazing for hiking. If you love the outdoors and love yourself I would recommend the 1g. Only down side is the price so go for the biggest value here. I promise you won\'t be dissapointed.',
          date: DateTime.now(),
          rating: 4,
          title: 'Go big or go home!'),
      ProductReview(
          reviewId: '3',
          productId: '6',
          reviewerId: '4',
          content:
              'This crumble is the bee\'s knees. Was a little expensive but worth every penny in my opinion. This one goes in the top 10 for me.',
          date: DateTime.now(),
          rating: 4,
          title: 'Worth it'),
      ProductReview(
          reviewId: '4',
          productId: '10',
          reviewerId: '7',
          content:
              'I bought a brownie then visited my favorite Ice Cream joint and made it an Ice Cream Brownie sundae. Would eat again and reccomend.',
          date: DateTime.now(),
          rating: 4,
          title: 'Take with Ice Cream'),
      ProductReview(
          reviewId: '5',
          productId: '9',
          reviewerId: '8',
          content:
              'I love these gummies and buy as many packs as I can whenever they are in stock. They are not only tasty but relieve my anxiety almost instantly and last hours. Thank you CBD!',
          date: DateTime.now(),
          rating: 5,
          title: 'These gummies are the BEST!'),
      ProductReview(
          reviewId: '6',
          productId: '1',
          reviewerId: '9',
          content:
              'Last time I was at the shop was told I should look out for the tangie and I did. This is the best decision I have made in a long time! Thanks for looking out @Drdankenstein ',
          date: DateTime.now(),
          rating: 5,
          title: 'New Favorite!'),
      ProductReview(
          reviewId: '7',
          productId: '3',
          reviewerId: '11',
          content:
              'I don\'t normally give bad reviews but I don\'t like the Sherb at all. Was well below my expectations and the high isn\'t worth it.',
          date: DateTime.now(),
          rating: 2,
          title: 'Don\'t like this Bud'),
      ProductReview(
          reviewId: '8',
          productId: '14',
          reviewerId: '12',
          content:
              'I have used many atomizers but none as bad as this one. The battery life is terrible, it wastes my Flower about 50% of the time and its not intuitive to load at all. Don\'t buy this crap!',
          date: DateTime.now(),
          rating: 1,
          title: 'This Atomizer Sucks!'),
      VenueReview(
          reviewId: '9',
          venueId: '2',
          reviewerId: '6',
          content:
              'I was in the mood for something edible and found my way to Peace of Pie Dispensory / Cannabis Bakery. This place is AMAZING! Easy to see prices for any variety of edibles as well as complete break downs of effects and terpenes counts. I was floor with the helpful staff and knowedgeable bud tenders. You all rock! Keep making the Cannabis world proud!',
          date: DateTime.now(),
          rating: 4,
          title: 'Best Pie Around!'),
    ];
  }

  @override
  Future<List<ProductReview>> getAllReviewsForProduct(String productId) async {
    return _allReviews
        .where((review) =>
            review is ProductReview && review.productId == productId)
        .map((review) => review as ProductReview)
        .toList();
  }

  @override
  Future<List<VenueReview>> getAllReviewsForVenue(String venueId) async {
    return _allReviews
        .where((review) => review is VenueReview && review.venueId == venueId)
        .map((review) => review as VenueReview)
        .toList();
  }

  @override
  Future<Review> getReviewById(String reviewId) async {
    return _allReviews.firstWhere((review) => review.reviewId == reviewId);
  }

  @override
  Future<void> addReview(Review review) async {
    _allReviews.add(review);
  }

  @override
  Future<void> deleteReview(String reviewId) async {
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
